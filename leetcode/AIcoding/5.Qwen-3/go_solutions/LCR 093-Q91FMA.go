package main

func lenLongestFib subsequence(arr []int) int {
    n := len(arr)
    dp := make(map[int]map[int]int)
    maxLen := 0

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            prev := arr[i] - arr[j]
            if val, ok := dp[arr[j]][prev]; ok {
                dp[arr[i]][arr[j]] = val + 1
                if dp[arr[i]][arr[j]] > maxLen {
                    maxLen = dp[arr[i]][arr[j]]
                }
            } else {
                dp[arr[i]][arr[j]] = 2
            }
        }
    }

    return maxLen
}