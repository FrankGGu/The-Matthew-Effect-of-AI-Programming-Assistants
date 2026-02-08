def minCost(cost: List[List[int]]) -> List[int]:
    n, m = len(cost), len(cost[0])
    dp = [[float('inf')] * m for _ in range(n)]
    dp[0][0] = cost[0][0]

    for i in range(n):
        for j in range(m):
            if i > 0:
                dp[i][j] = min(dp[i][j], dp[i-1][j] + cost[i][j])
            if j > 0:
                dp[i][j] = min(dp[i][j], dp[i][j-1] + cost[i][j])

    return [dp[i][j] for i in range(n) for j in range(m)]