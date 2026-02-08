class Solution:
    def minCost(self, houses: list[int], cost: list[list[int]], m: int, n: int, target: int) -> int:
        dp = {}

        def solve(idx, neighborhoods, prev_color):
            if idx == m:
                return 0 if neighborhoods == target else float('inf')

            if (idx, neighborhoods, prev_color) in dp:
                return dp[(idx, neighborhoods, prev_color)]

            res = float('inf')
            if houses[idx] == 0:
                for color in range(1, n + 1):
                    new_neighborhoods = neighborhoods + (color != prev_color)
                    res = min(res, cost[idx][color - 1] + solve(idx + 1, new_neighborhoods, color))
            else:
                color = houses[idx]
                new_neighborhoods = neighborhoods + (color != prev_color)
                res = min(res, solve(idx + 1, new_neighborhoods, color))

            dp[(idx, neighborhoods, prev_color)] = res
            return res

        ans = solve(0, 0, 0)
        return ans if ans != float('inf') else -1