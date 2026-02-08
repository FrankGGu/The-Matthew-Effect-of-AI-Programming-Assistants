func deleteAndEarn(nums []int) int {
    maxVal := 0
    for _, num := range nums {
        if num > maxVal {
            maxVal = num
        }
    }

    values := make([]int, maxVal+1)
    for _, num := range nums {
        values[num] += num
    }

    dp := make([]int, maxVal+1)
    dp[1] = values[1]

    for i := 2; i <= maxVal; i++ {
        dp[i] = max(dp[i-1], dp[i-2]+values[i])
    }

    return dp[maxVal]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}