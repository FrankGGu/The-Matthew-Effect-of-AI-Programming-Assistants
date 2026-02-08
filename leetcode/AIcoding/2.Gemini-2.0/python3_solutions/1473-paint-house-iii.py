class Solution:
    def minCost(self, houses: list[int], cost: list[list[int]], m: int, n: int, target: int) -> int:
        dp = {}

        def solve(i, neighborhoods, prev_color):
            if i == m:
                return 0 if neighborhoods == target else float('inf')

            if (i, neighborhoods, prev_color) in dp:
                return dp[(i, neighborhoods, prev_color)]

            ans = float('inf')
            if houses[i] == 0:
                for color in range(1, n + 1):
                    new_neighborhoods = neighborhoods + (color != prev_color)
                    ans = min(ans, cost[i][color - 1] + solve(i + 1, new_neighborhoods, color))
            else:
                color = houses[i]
                new_neighborhoods = neighborhoods + (color != prev_color)
                ans = solve(i + 1, new_neighborhoods, color)

            dp[(i, neighborhoods, prev_color)] = ans
            return ans

        result = solve(0, 0, 0)
        return result if result != float('inf') else -1