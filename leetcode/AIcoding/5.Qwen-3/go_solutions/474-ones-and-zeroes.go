package main

func findMaxForm(strs []string, m int, n int) int {
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    for _, s := range strs {
        zeros := 0
        ones := 0
        for _, c := range s {
            if c == '0' {
                zeros++
            } else {
                ones++
            }
        }
        for i := m; i >= zeros; i-- {
            for j := n; j >= ones; j-- {
                dp[i][j] = max(dp[i][j], dp[i-zeros][j-ones]+1)
            }
        }
    }
    return dp[m][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}