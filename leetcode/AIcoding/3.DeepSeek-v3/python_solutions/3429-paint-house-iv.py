class Solution:
    def minCost(self, houses: List[int], cost: List[List[int]], m: int, n: int, target: int) -> int:
        dp = {}

        def dfs(i, prev_color, groups):
            if i == m:
                return 0 if groups == target else float('inf')
            if (i, prev_color, groups) in dp:
                return dp[(i, prev_color, groups)]

            res = float('inf')
            if houses[i] != 0:
                new_groups = groups + (1 if houses[i] != prev_color else 0)
                res = dfs(i + 1, houses[i], new_groups)
            else:
                for color in range(1, n + 1):
                    new_groups = groups + (1 if color != prev_color else 0)
                    res = min(res, cost[i][color - 1] + dfs(i + 1, color, new_groups))

            dp[(i, prev_color, groups)] = res
            return res

        result = dfs(0, -1, 0)
        return result if result != float('inf') else -1