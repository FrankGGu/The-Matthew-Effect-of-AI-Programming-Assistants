func lengthOfLIS(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    for i := range dp {
        dp[i] = 1
    }

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }

    res := 0
    for _, v := range dp {
        res = max(res, v)
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}