def paintWalls(paintTime: List[int], time: int) -> int:
    n = len(paintTime)
    dp = [0] * (n + 1)

    for i in range(1, n + 1):
        dp[i] = dp[i - 1] + paintTime[i - 1]
        for j in range(i - 1, -1, -1):
            if dp[i] - dp[j] > time:
                break
            dp[i] = min(dp[i], dp[j] + paintTime[i - 1])

    return dp[n]