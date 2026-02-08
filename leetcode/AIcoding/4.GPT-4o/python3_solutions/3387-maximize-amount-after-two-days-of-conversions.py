def maxAmount(num: List[int]) -> int:
    n = len(num)
    if n < 3:
        return 0

    dp = [[0] * n for _ in range(3)]

    for i in range(1, 3):
        for j in range(n):
            dp[i][j] = dp[i][j-1]
            if j >= 2:
                dp[i][j] = max(dp[i][j], dp[i-1][j-2] + num[j])

    return dp[2][n-1]