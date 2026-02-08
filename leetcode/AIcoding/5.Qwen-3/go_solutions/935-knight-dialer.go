package main

func knightDialer(n int) int {
    MOD := 1000000007
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, 10)
    }

    for i := 0; i < 10; i++ {
        dp[0][i] = 1
    }

    transitions := [10][]int{
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

    for i := 1; i < n; i++ {
        for j := 0; j < 10; j++ {
            for _, next := range transitions[j] {
                dp[i][j] += dp[i-1][next]
                dp[i][j] %= MOD
            }
        }
    }

    result := 0
    for i := 0; i < 10; i++ {
        result += dp[n-1][i]
        result %= MOD
    }

    return result
}