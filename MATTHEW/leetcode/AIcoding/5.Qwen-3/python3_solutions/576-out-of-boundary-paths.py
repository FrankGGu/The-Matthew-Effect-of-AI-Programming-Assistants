class Solution:
    def findPaths(self, m: int, n: int, maxMove: int, startRow: int, startColumn: int) -> int:
        from functools import lru_cache

        MOD = 10**9 + 7

        @lru_cache(None)
        def dfs(i, j, moves):
            if i < 0 or i >= m or j < 0 or j >= n:
                return 1
            if moves == 0:
                return 0
            res = 0
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                ni, nj = i + dx, j + dy
                res += dfs(ni, nj, moves - 1)
                res %= MOD
            return res

        return dfs(startRow, startColumn, maxMove)