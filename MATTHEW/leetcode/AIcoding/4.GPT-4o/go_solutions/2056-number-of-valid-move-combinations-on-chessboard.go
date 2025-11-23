func knightDialer(n int) int {
    mod := 1000000007
    moves := [][]int{
        {4, 6},
        {6, 8},
        {7, 9},
        {4, 8},
        {},
        {},
        {0, 1, 7},
        {2, 4},
        {1, 3},
        {2, 6},
    }

    dp := make([]int, 10)
    for i := range dp {
        dp[i] = 1
    }

    for i := 1; i < n; i++ {
        newDp := make([]int, 10)
        for j := 0; j < 10; j++ {
            for _, move := range moves[j] {
                newDp[move] = (newDp[move] + dp[j]) % mod
            }
        }
        dp = newDp
    }

    result := 0
    for _, count := range dp {
        result = (result + count) % mod
    }

    return result
}