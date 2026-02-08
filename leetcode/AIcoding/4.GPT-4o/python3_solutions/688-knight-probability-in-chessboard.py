def knightProbability(n: int, k: int, row: int, column: int) -> float:
    dp = [[[0] * n for _ in range(n)] for _ in range(k + 1)]
    directions = [(2, 1), (1, 2), (-1, 2), (-2, 1), (-2, -1), (-1, -2), (1, -2), (2, -1)]

    dp[0][row][column] = 1.0

    for step in range(1, k + 1):
        for r in range(n):
            for c in range(n):
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < n and 0 <= nc < n:
                        dp[step][r][c] += dp[step - 1][nr][nc] / 8.0

    return sum(dp[k][r][c] for r in range(n) for c in range(n))