class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1
        if n >= 10:
            n = 10
        res = 10
        for i in range(2, n + 1):
            temp = 9
            for j in range(1, i):
                temp *= (10 - j + 1)
            res += temp
        return res