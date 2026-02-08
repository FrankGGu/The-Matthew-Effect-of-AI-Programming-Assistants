class Solution:
    def sumZero(self, n: int) -> list[int]:
        res = []
        if n % 2 == 1:
            res.append(0)
            n -= 1
        for i in range(1, n // 2 + 1):
            res.append(i)
            res.append(-i)
        return res