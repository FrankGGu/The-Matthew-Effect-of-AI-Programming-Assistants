class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:
        ans = 0
        for i in range(min(limit, n) + 1):
            remaining = n - i
            low = max(0, remaining - 2 * limit)
            high = min(limit, remaining)
            ans += max(0, high - low + 1)
        return ans