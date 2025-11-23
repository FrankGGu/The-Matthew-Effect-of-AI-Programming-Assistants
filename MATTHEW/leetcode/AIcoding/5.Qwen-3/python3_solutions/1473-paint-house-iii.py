class Solution:
    def minCost(self, costs: List[int], m: int, n: int, target: int) -> int:
        import sys
        sys.setrecursionlimit(10000)
        from functools import lru_cache

        @lru_cache(None)
        def dp(i, prev_color, k):
            if i == m:
                return 0 if k == 0 else float('inf')
            if k < 0:
                return float('inf')
            res = float('inf')
            for color in range(n):
                if color == prev_color:
                    continue
                res = min(res, costs[i][color] + dp(i + 1, color, k - 1))
            return res

        result = dp(0, -1, target)
        return result if result != float('inf') else -1