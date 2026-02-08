from functools import lru_cache

class Solution:
    def minDays(self, n: int) -> int:
        @lru_cache(maxsize=None)
        def dfs(remaining):
            if remaining <= 1:
                return remaining
            return 1 + min(remaining % 2 + dfs(remaining // 2), remaining % 3 + dfs(remaining // 3))

        return dfs(n)