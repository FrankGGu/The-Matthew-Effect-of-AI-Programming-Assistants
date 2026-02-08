def minCost(captions: List[str], cost: List[int], target: int) -> int:
    n = len(captions)
    dp = [[float('inf')] * (target + 1) for _ in range(n + 1)]
    dp[0][0] = 0

    for i in range(1, n + 1):
        for j in range(target + 1):
            dp[i][j] = dp[i - 1][j]
            if j >= 1:
                dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + cost[i - 1])

    return dp[n][target] if dp[n][target] != float('inf') else -1