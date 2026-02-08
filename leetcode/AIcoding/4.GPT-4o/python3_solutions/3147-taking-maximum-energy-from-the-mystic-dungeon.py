def maxEnergy(A: List[int], B: List[int], C: List[int]) -> int:
    n = len(A)
    dp = [[0] * 4 for _ in range(n + 1)]

    for i in range(1, n + 1):
        for j in range(4):
            dp[i][j] = dp[i - 1][j]
            if j > 0:
                dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + A[i - 1])
            if j < 3:
                dp[i][j] = max(dp[i][j], dp[i - 1][j + 1] + B[i - 1])
            dp[i][j] = max(dp[i][j], dp[i - 1][j] + C[i - 1])

    return max(dp[n])