class Solution:
    def minSquare(self, width: int, height: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(w, h):
            if w > h:
                w, h = h, w
            if w == 0:
                return 0
            if w == 1:
                return h
            res = float('inf')
            for i in range(1, w + 1):
                res = min(res, dfs(w - i, h) + dfs(i, h - i))
            for i in range(1, w):
                res = min(res, dfs(i, h) + dfs(w - i, h))
            for i in range(1, w):
                res = min(res, dfs(w, h - i) + dfs(w - i, i))
            return res

        return dfs(width, height)