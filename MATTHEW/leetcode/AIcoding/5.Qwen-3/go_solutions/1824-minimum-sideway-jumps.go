package main

func minSideJumps(n int, d [][]int) int {
    dp := [3]int{0, 1, 2}
    for i := 0; i < n; i++ {
        next := [3]int{dp[0], dp[1], dp[2]}
        for j := 0; j < 3; j++ {
            if d[i][j] == 1 {
                next[j] = 1e9
            }
        }
        for j := 0; j < 3; j++ {
            if next[j] != 1e9 {
                for k := 0; k < 3; k++ {
                    if j != k {
                        next[j] = min(next[j], dp[k]+1)
                    }
                }
            }
        }
        dp = next
    }
    return min(dp[0], min(dp[1], dp[2]))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}