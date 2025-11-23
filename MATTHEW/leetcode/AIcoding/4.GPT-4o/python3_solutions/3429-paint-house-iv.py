class Solution:
    def minCost(self, houses: List[int], cost: List[List[int]], m: int, n: int, target: int) -> int:
        dp = [[[float('inf')] * (target + 1) for _ in range(n + 1)] for _ in range(m + 1)]
        dp[0][0][0] = 0

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                for t in range(1, target + 1):
                    if houses[i - 1] == 0:
                        dp[i][j][t] = min(dp[i][j][t], cost[i - 1][j - 1] + min(dp[i - 1][k][t - (1 if k != j else 0)] for k in range(1, n + 1)))
                    elif houses[i - 1] == j:
                        dp[i][j][t] = min(dp[i][j][t], min(dp[i - 1][k][t - (1 if k != j else 0)] for k in range(1, n + 1)))
                    else:
                        continue

        answer = min(dp[m][j][target] for j in range(1, n + 1))
        return answer if answer != float('inf') else -1