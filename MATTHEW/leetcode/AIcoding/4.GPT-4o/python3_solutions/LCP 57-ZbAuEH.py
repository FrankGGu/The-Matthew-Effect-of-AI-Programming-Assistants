def mouseAndCheese(mouse: List[int], cheese: List[int]) -> int:
    n = len(mouse)
    dp = [[0] * (n + 1) for _ in range(n + 1)]

    for i in range(n + 1):
        for j in range(n + 1):
            if i == 0 and j == 0:
                dp[i][j] = 0
            elif i == 0:
                dp[i][j] = dp[i][j - 1] + cheese[j - 1]
            elif j == 0:
                dp[i][j] = dp[i - 1][j] + mouse[i - 1]
            else:
                dp[i][j] = max(dp[i - 1][j] + mouse[i - 1], dp[i][j - 1] + cheese[j - 1])

    return dp[n][n]