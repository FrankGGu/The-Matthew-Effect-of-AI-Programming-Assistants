def minimumCoins(prices):
    n = len(prices)
    dp = [0] * n
    dp[0] = prices[0]
    for i in range(1, n):
        dp[i] = dp[i - 1] + prices[i]
        for j in range(max(0, i - prices[i]), i):
            dp[i] = min(dp[i], dp[j] + prices[i])
    return dp[n - 1]