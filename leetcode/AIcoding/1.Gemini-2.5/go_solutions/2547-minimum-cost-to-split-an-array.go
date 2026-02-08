package main

import "math"

func minCostToSplitArray(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for i := 1; i <= n; i++ {
        currentTrim := 0
        freq := make([]int, n) // nums[x] values are 0 <= nums[x] < n

        for j := i - 1; j >= 0; j-- {
            num := nums[j]
            freq[num]++

            if freq[num] == 2 {
                currentTrim++
            }

            costSubarray := currentTrim + k

            if dp[j] != math.MaxInt32 {
                dp[i] = min(dp[i], dp[j]+costSubarray)
            }
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}