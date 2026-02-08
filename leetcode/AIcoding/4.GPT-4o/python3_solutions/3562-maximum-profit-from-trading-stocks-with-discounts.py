def maxProfit(prices, discounts):
    n = len(prices)
    dp = [[0] * (n + 1) for _ in range(2)]

    for i in range(1, n + 1):
        for j in range(2):
            if j == 0:
                dp[j][i] = max(dp[j][i - 1], dp[1][i - 1] + prices[i - 1] - (discounts[i - 1] if i - 1 < len(discounts) else 0))
            else:
                dp[j][i] = max(dp[j][i - 1], dp[0][i - 1] - prices[i - 1])

    return dp[0][n]