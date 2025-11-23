class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:
        def count(x):
            if x < 0:
                return 0
            return (x + 1) * (x + 2) // 2

        return count(n) - 3 * count(n - limit - 1) + 3 * count(n - 2 * limit - 2) - count(n - 3 * limit - 3)