def numWays(n: int, k: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return k
    dp = [0] * (n + 1)
    dp[0], dp[1] = 1, k
    for i in range(2, n + 1):
        dp[i] = (k - 1) * dp[i - 1] + (k - 1) * dp[i - 2]
    return dp[n]