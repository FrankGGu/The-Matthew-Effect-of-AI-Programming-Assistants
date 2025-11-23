class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:
        def count_ways(a, b, c):
            return max(0, a - b + 1)

        total = 0
        for i in range(min(n, limit) + 1):
            remaining = n - i
            if remaining < 0:
                continue
            for j in range(min(remaining, limit) + 1):
                k = remaining - j
                if k <= limit:
                    total += 1
        return total