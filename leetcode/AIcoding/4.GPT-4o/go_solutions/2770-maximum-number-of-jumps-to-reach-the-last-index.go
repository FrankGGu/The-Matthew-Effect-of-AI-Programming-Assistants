func maxJumps(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    dp[n-1] = 1

    for i := n - 2; i >= 0; i-- {
        maxJumps := 0
        for j := i + 1; j < n && nums[j] > nums[i]; j++ {
            maxJumps = max(maxJumps, dp[j])
        }
        if maxJumps > 0 {
            dp[i] = maxJumps + 1
        } else {
            dp[i] = 1
        }
    }

    maxResult := 0
    for _, jumps := range dp {
        maxResult = max(maxResult, jumps)
    }

    return maxResult
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}