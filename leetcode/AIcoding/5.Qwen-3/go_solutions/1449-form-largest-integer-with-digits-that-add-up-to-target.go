package main

func largestNumber(cost []int, target int) string {
    dp := make([]string, target+1)
    for i := range dp {
        dp[i] = "-1"
    }
    dp[0] = ""
    for i := 1; i <= target; i++ {
        for j := 0; j < 9; j++ {
            if i >= cost[j] && dp[i-cost[j]] != "-1" {
                candidate := dp[i-cost[j]] + string('1'+j)
                if len(candidate) > len(dp[i]) || (len(candidate) == len(dp[i]) && candidate > dp[i]) {
                    dp[i] = candidate
                }
            }
        }
    }
    if dp[target] == "-1" {
        return ""
    }
    return dp[target]
}