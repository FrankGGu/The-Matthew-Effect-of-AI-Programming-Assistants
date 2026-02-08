package main

func domino(n int, m int, broken [][]int) int {
    MOD := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 1<<(m+1))
    }
    dp[0][0] = 1

    grid := make([][]bool, n)
    for i := range grid {
        grid[i] = make([]bool, m)
    }
    for _, b := range broken {
        grid[b[0]][b[1]] = true
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            newDp := make([][]int, n+1)
            for k := range newDp {
                newDp[k] = make([]int, 1<<(m+1))
            }

            for mask := 0; mask < (1 << m); mask++ {
                for k := 0; k < 2; k++ {
                    if k == 1 && (mask&(1<<j) != 0 || grid[i][j]) {
                        continue
                    }
                    newMask := mask
                    if k == 1 {
                        newMask |= 1 << j
                    }

                    if j == m-1 {
                        newDp[i+1][newMask>>1] = (newDp[i+1][newMask>>1] + dp[i][mask]) % MOD
                    } else {
                        newDp[i][newMask] = (newDp[i][newMask] + dp[i][mask]) % MOD
                    }
                }
            }
            dp = newDp
        }
    }

    return dp[n][0]
}