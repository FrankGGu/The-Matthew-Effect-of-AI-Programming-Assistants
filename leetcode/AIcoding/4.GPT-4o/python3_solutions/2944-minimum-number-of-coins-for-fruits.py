def min_coins(fruits: List[int], coins: List[int]) -> int:
    n = len(fruits)
    dp = [float('inf')] * (n + 1)
    dp[0] = 0

    for i in range(1, n + 1):
        for j in range(i):
            dp[i] = min(dp[i], dp[j] + coins[i - 1])

    return dp[n]