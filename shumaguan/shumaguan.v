module shumaguan(
	input 				sys_clk,		//时钟输入，50MHz
	input 				sys_rst_n,	//系统复位信号，下降沿有效
	
	//input 				key,			//按键信号输入
	
	output reg [7:0] 	dig_duan,	//数码管段控制，共8段，低电平有效
	output reg [5:0] 	dig_wei	//数码管位控制，共有六位，低电平有效
//	output reg			pwm			//PWM信号输出，控制电机信号，低电平有效
);

reg [3:0]	speed;		//速度等级，取值范围：0~15
/* 数码管显示模块 
*	说明：适用于共阳数码管，0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90, //0~9
*						    0x88,0x83,0xc6,0xa1,0x86,0x8e  //A~F
*/
always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		dig_duan <= 8'b0000_0000;	//数码管全亮
		dig_wei <= 6'b111_110;		//选通最右边一位数码管
		speed <= 4'd0;
	end
	else begin
		speed <=4'b0001; 				//速度等级选择为1，之后可以改
		dig_wei <= 6'b111_110;		//选通最右边一位数码管	
		case(speed)
			0: dig_duan <= 8'b1100_0000;			//显示数字0
			1: dig_duan <= 8'b1111_1001;			//显示数字1
			2: dig_duan <= 8'b1010_0100;			//显示数字2
			3: dig_duan <= 8'b1011_0000;			//显示数字3
			4: dig_duan <= 8'b1001_1001;			//显示数字4
			5: dig_duan <= 8'b1001_0010;			//显示数字5
			6: dig_duan <= 8'b1000_0010;			//显示数字6
			7: dig_duan <= 8'b1111_1000;			//显示数字7
			8: dig_duan <= 8'b1000_0000;			//显示数字8
			9: dig_duan <= 8'b1001_0000;			//显示数字9
			default: dig_duan <= 8'b0000_0000;	//全部点亮
		endcase
	end
end
endmodule