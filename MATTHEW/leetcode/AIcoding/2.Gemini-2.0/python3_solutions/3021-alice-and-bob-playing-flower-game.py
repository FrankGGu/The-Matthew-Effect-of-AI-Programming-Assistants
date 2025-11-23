class Solution:
    def flowerGame(self, n: int, m: int) -> int:
        if n > m:
            n, m = m, n

        return (n // 2) * m + (n % 2) * (m // 2)