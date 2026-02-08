def kthSmallest(denominations: List[int], k: int) -> int:
    denominations.sort()
    dp = [0] * (k + 1)
    dp[0] = 1
    for coin in denominations:
        for j in range(coin, k + 1):
            dp[j] += dp[j - coin]
    return len([x for x in dp if x > 0]) if k > 0 else 0