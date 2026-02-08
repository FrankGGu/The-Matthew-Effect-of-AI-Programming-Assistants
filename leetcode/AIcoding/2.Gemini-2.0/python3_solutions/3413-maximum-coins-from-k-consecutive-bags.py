from functools import lru_cache

class Solution:
    def maxTotalValue(self, bags: list[list[int]], k: int) -> int:
        n = len(bags)

        @lru_cache(None)
        def dp(i, remaining):
            if remaining == 0:
                return 0
            if i == n:
                return 0

            res = dp(i + 1, remaining)
            curr_sum = 0
            for j in range(min(len(bags[i]), remaining)):
                curr_sum += bags[i][j]
                res = max(res, curr_sum + dp(i + 1, remaining - (j + 1)))

            return res

        return dp(0, k)