package main

func minTimeToCook(p *[]int, target int) int {
    n := len(*p)
    dp := make([]int, target+1)
    for i := range dp {
        dp[i] = 1 << 30
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        t := (*p)[i]
        for j := target; j >= t; j-- {
            if dp[j-t] + t < dp[j] {
                dp[j] = dp[j-t] + t
            }
        }
    }
    return dp[target]
}