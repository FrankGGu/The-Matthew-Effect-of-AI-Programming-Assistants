class Solution:
    def minimumOperations(self, leaves: str) -> int:
        n = len(leaves)
        dp = [[float('inf')] * 3 for _ in range(n)]
        dp[0][0] = 1 if leaves[0] == 'y' else 0
        for i in range(1, n):
            if leaves[i] == 'r':
                dp[i][0] = dp[i-1][0]
                dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + 1
                dp[i][2] = min(dp[i-1][1], dp[i-1][2])
            else:
                dp[i][0] = dp[i-1][0] + 1
                dp[i][1] = min(dp[i-1][0], dp[i-1][1])
                dp[i][2] = min(dp[i-1][1], dp[i-1][2]) + 1
        return dp[-1][2]