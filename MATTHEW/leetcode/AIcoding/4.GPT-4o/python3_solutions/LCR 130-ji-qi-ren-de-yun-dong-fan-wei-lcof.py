def numWays(ways: List[str]) -> int:
    n = len(ways)
    dp = [0] * (n + 1)
    dp[0] = 1

    for way in ways:
        for i in range(n, 0, -1):
            dp[i] += dp[i - 1] * (way.count('Y') + 1)

    return dp[n] % (10**9 + 7)