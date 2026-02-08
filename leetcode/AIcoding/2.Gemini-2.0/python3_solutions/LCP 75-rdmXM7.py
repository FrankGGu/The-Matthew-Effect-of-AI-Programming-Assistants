def minCost(cost):
    n = len(cost)
    dp = [float('inf')] * (n + 1)
    dp[0] = 0
    for i in range(1, n + 1):
        dp[i] = min(dp[i - 1] + cost[i - 1], dp[max(0, i - 3)] if i >= 3 else float('inf'))
    return dp[n]