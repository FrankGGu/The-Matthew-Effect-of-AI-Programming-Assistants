def waysToReach(stairs: int, k: int) -> int:
    mod = 10**9 + 7
    if stairs == 0:
        return 1
    if stairs < 0:
        return 0

    dp = [0] * (stairs + 1)
    dp[0] = 1

    for i in range(1, stairs + 1):
        for j in range(1, k + 1):
            if i - j >= 0:
                dp[i] = (dp[i] + dp[i - j]) % mod

    return dp[stairs]