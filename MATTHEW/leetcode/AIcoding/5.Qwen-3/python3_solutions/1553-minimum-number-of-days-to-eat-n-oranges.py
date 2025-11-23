class Solution:
    def minDays(self, n: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(oranges):
            if oranges <= 1:
                return oranges
            return 1 + min(dfs(oranges // 2) + oranges % 2, dfs(oranges // 3) + oranges % 3)

        return dfs(n)