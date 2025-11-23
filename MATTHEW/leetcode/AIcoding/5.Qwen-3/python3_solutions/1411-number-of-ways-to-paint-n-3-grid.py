class Solution:
    def numWays(self, n: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return 6
        a, b = 6, 6
        for _ in range(2, n + 1):
            a, b = b, (a * 2 + b * 2) % (10**9 + 7)
        return b