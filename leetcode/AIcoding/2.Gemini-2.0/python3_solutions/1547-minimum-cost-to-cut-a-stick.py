def minCost(n: int, cuts: list[int]) -> int:
    cuts = [0] + sorted(cuts) + [n]
    k = len(cuts)
    dp = [[0] * k for _ in range(k)]

    for length in range(2, k):
        for i in range(k - length):
            j = i + length
            dp[i][j] = float('inf')
            for m in range(i + 1, j):
                dp[i][j] = min(dp[i][j], dp[i][m] + dp[m][j] + cuts[j] - cuts[i])

    return dp[0][k - 1]