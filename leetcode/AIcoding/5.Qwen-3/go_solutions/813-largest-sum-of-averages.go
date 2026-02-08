package main

func largestSumOfAverages(nums []int, k int) float64 {
    n := len(nums)
    dp := make([]float64, n)
    for i := 0; i < n; i++ {
        dp[i] = float64(nums[i])
    }
    for k1 := 1; k1 < k; k1++ {
        newDp := make([]float64, n)
        for i := 0; i < n; i++ {
            maxVal := 0.0
            sum := 0.0
            for j := i; j < n; j++ {
                sum += float64(nums[j])
                if j+1 < n {
                    maxVal = max(maxVal, sum + dp[j+1])
                } else {
                    maxVal = max(maxVal, sum)
                }
            }
            newDp[i] = maxVal
        }
        dp = newDp
    }
    return dp[0]
}

func max(a, b float64) float64 {
    if a > b {
        return a
    }
    return b
}