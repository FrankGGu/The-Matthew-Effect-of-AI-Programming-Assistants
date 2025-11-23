class Solution:
    def splitNum(self, num: int) -> int:
        s = sorted(str(num))
        num1 = num2 = 0
        for i, c in enumerate(s):
            if i % 2 == 0:
                num1 = num1 * 10 + int(c)
            else:
                num2 = num2 * 10 + int(c)
        return num1 + num2