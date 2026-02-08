class Solution:
    def minCost(self, houses: List[int], cost: List[List[int]], m: int, n: int, target: int) -> int:
        dp = [[[float('inf')] * (target + 1) for _ in range(n + 1)] for _ in range(m + 1)]
        dp[0][0][0] = 0

        for i in range(1, m + 1):
            for j in range(n + 1):
                for k in range(target + 1):
                    if houses[i - 1] != 0:
                        color = houses[i - 1]
                        dp[i][color][k] = min(dp[i][color][k], dp[i - 1][color][k] if k > 0 else float('inf'))
                        if k > 0:
                            for c in range(1, n + 1):
                                if c != color:
                                    dp[i][color][k] = min(dp[i][color][k], dp[i - 1][c][k - 1])
                    else:
                        for color in range(1, n + 1):
                            if j == color:
                                dp[i][color][k] = min(dp[i][color][k], dp[i - 1][color][k] + cost[i - 1][color - 1])
                            else:
                                dp[i][color][k] = min(dp[i][color][k], dp[i - 1][j][k - 1] + cost[i - 1][color - 1])

        result = min(dp[m][j][target] for j in range(1, n + 1))
        return result if result != float('inf') else -1