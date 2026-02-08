class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:
        count = 0
        for a in range(min(n, limit) + 1):
            remaining = n - a
            if remaining < 0:
                continue
            max_b = min(remaining, limit)
            min_b = max(0, remaining - max_b)
            if min_b > max_b:
                continue
            count += max_b - min_b + 1
        return count