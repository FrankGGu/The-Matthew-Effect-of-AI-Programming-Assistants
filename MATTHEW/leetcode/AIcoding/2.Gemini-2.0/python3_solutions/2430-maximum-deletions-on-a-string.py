def deleteString(s: str) -> int:
    n = len(s)
    dp = [1] * n
    lcp = [[0] * n for _ in range(n)]

    for i in range(n - 1, -1, -1):
        for j in range(n - 1, -1, -1):
            if s[i] == s[j]:
                lcp[i][j] = lcp[i + 1][j + 1] + 1
            else:
                lcp[i][j] = 0

    for i in range(n - 2, -1, -1):
        if lcp[i][i + 1] >= (n - i) // 2:
            dp[i] = max(dp[i], dp[i + (n - i) // 2] + 1)

        for j in range(i + 1, n):
            if lcp[i][j] >= (j - i):
                dp[i] = max(dp[i], dp[j] + 1)

    return dp[0]