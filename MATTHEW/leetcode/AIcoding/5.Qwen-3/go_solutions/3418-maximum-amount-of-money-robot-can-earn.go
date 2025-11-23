package main

func maxMoney(n int, k int, s string) int {
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = -1
    }
    return dfs(0, k, s, dp)
}

func dfs(pos int, k int, s string, dp []int) int {
    if pos >= len(s) {
        return 0
    }
    if dp[pos] != -1 {
        return dp[pos]
    }
    res := 0
    for i := 0; i <= k && pos+i < len(s); i++ {
        if s[pos+i] == '1' {
            res = max(res, dfs(pos+i+1, k, s, dp))
        }
    }
    dp[pos] = res
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}