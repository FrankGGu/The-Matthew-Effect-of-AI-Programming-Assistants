package main

func minTimeToMakeArraySumAtMostX(target int, arr []int) int {
    n := len(arr)
    dp := make([]int, target+1)
    for i := 0; i < n; i++ {
        val := arr[i]
        for j := target; j >= val; j-- {
            dp[j] = min(dp[j], dp[j-val]+1)
        }
    }
    return dp[target]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}