class Solution:
    def splitNum(self, num: int) -> int:
        s_num = str(num)
        digits = sorted(list(s_num))

        num1_str = digits[0] + digits[2]
        num2_str = digits[1] + digits[3]

        num1 = int(num1_str)
        num2 = int(num2_str)

        return num1 + num2