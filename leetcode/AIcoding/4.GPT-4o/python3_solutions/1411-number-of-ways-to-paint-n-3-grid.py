class Solution:
    def numOfWays(self, n: int) -> int:
        mod = 10**9 + 7
        if n == 1:
            return 12

        a, b = 6, 6

        for _ in range(2, n + 1):
            a, b = (b * 3) % mod, (a * 2 + b * 2) % mod

        return (a + b) % mod