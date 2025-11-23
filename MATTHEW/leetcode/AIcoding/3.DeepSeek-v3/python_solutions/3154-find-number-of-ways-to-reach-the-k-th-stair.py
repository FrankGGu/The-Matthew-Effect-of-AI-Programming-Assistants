class Solution:
    def waysToReachStair(self, k: int) -> int:
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(pos, jump, up):
            if pos > k + 1:
                return 0
            res = 0
            if pos == k:
                res += 1
            if up:
                res += dfs(pos + (1 << jump), jump + 1, False)
            if pos > 0:
                res += dfs(pos - 1, jump, True)
            return res

        return dfs(1, 0, True)