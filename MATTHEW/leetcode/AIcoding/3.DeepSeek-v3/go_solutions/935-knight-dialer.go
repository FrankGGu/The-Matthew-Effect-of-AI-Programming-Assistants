func knightDialer(n int) int {
    const mod = 1e9 + 7
    moves := [][]int{
        {4, 6},
        {6, 8},
        {7, 9},
        {4, 8},
        {0, 3, 9},
        {},
        {0, 1, 7},
        {2, 6},
        {1, 3},
        {2, 4},
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 10)
    }

    for i := 0; i < 10; i++ {
        dp[1][i] = 1
    }

    for step := 2; step <= n; step++ {
        for num := 0; num < 10; num++ {
            for _, next := range moves[num] {
                dp[step][num] = (dp[step][num] + dp[step-1][next]) % mod
            }
        }
    }

    total := 0
    for i := 0; i < 10; i++ {
        total = (total + dp[n][i]) % mod
    }

    return total
}