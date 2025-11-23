class Solution:
    def countHousePlacements(self, n: int) -> int:
        mod = 10**9 + 7
        if n == 0:
            return 1

        a, b = 1, 1
        for _ in range(1, n + 1):
            a, b = b, (a + b) % mod

        return (b * b) % mod