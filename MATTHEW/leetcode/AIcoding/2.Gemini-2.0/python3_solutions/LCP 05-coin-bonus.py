def solve():
    n, m = map(int, input().split())
    grid = []
    for _ in range(n):
        grid.append(list(map(int, input().split())))

    dp = [[0] * m for _ in range(n)]
    dp[0][0] = grid[0][0]

    for i in range(n):
        for j in range(m):
            if i > 0:
                dp[i][j] = max(dp[i][j], dp[i - 1][j] + grid[i][j])
            if j > 0:
                dp[i][j] = max(dp[i][j], dp[i][j - 1] + grid[i][j])

    print(dp[n - 1][m - 1])

solve()