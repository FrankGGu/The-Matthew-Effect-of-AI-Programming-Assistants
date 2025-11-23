class Solution:
    def minSidewayJumps(self, n: int, dp: List[List[int]]) -> int:
        for i in range(1, n):
            for j in range(3):
                if dp[i][j] == -1:
                    continue
                for k in range(3):
                    if k != j and dp[i][j] + 1 < dp[i+1][k]:
                        dp[i+1][k] = dp[i][j] + 1
        return min(dp[n])