class Solution:
    def leastOpsExpressTarget(self, x: int, target: int) -> int:
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(t):
            if t == 0:
                return 0
            if t == 1:
                return 1
            k = 0
            while x ** (k + 1) <= t:
                k += 1
            res = k + dfs(t - x ** k) if k != 0 else float('inf')
            if x ** (k + 1) - t < t:
                res = min(res, k + 1 + dfs(x ** (k + 1) - t))
            return res

        return dfs(target) - 1