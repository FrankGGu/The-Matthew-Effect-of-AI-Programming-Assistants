def minimumOperations(leaves: str) -> int:
    n = len(leaves)
    dp = [[float('inf')] * 3 for _ in range(n + 1)]
    dp[0][0] = 0

    for i in range(1, n + 1):
        dp[i][0] = dp[i - 1][0] + (leaves[i - 1] != 'r')
        dp[i][1] = min(dp[i - 1][0], dp[i - 1][1]) + (leaves[i - 1] != 'y')
        dp[i][2] = min(dp[i - 1][1], dp[i - 1][2]) + (leaves[i - 1] != 'g')

    return dp[n][2]