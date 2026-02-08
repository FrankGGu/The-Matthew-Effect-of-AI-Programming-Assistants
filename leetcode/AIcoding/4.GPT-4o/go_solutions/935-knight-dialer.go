package main

func knightDialer(N int) int {
    mod := 1000000007
    moves := [][]int{
        {2, 1}, {2, -1}, {-2, 1}, {-2, -1},
        {1, 2}, {1, -2}, {-1, 2}, {-1, -2},
    }
    dp := make([][]int, 4)
    for i := range dp {
        dp[i] = make([]int, 3)
    }
    for i := 0; i < 4; i++ {
        for j := 0; j < 3; j++ {
            if i == 0 && j == 0 || i == 0 && j == 1 || i == 0 && j == 2 ||
               i == 1 && j == 0 || i == 1 && j == 2 ||
               i == 2 && j == 1 || i == 3 && j == 1 {
                dp[i][j] = 1
            }
        }
    }

    for step := 1; step < N; step++ {
        newDp := make([][]int, 4)
        for i := range newDp {
            newDp[i] = make([]int, 3)
        }
        for i := 0; i < 4; i++ {
            for j := 0; j < 3; j++ {
                for _, move := range moves {
                    ni, nj := i+move[0], j+move[1]
                    if ni >= 0 && ni < 4 && nj >= 0 && nj < 3 && !(ni == 3 && nj == 0) {
                        newDp[i][j] = (newDp[i][j] + dp[ni][nj]) % mod
                    }
                }
            }
        }
        dp = newDp
    }

    ans := 0
    for i := 0; i < 4; i++ {
        for j := 0; j < 3; j++ {
            ans = (ans + dp[i][j]) % mod
        }
    }
    return ans
}