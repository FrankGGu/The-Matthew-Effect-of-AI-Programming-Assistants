package main

func maxValueOfFunction(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = nums[i]
    }
    for step := 1; step < k; step++ {
        nextDp := make([]int, n)
        for i := 0; i < n; i++ {
            if i > 0 {
                nextDp[i] = max(nextDp[i], dp[i-1]+nums[i])
            }
            if i < n-1 {
                nextDp[i] = max(nextDp[i], dp[i+1]+nums[i])
            }
        }
        dp = nextDp
    }
    maxVal := dp[0]
    for _, v := range dp {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}