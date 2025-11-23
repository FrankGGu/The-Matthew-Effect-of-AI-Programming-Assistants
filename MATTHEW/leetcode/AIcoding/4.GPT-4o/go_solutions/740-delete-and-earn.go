func deleteAndEarn(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    dp := make([]int, maxNum+1)
    for _, num := range nums {
        dp[num] += num
    }

    for i := 2; i <= maxNum; i++ {
        dp[i] = max(dp[i-1], dp[i-2]+dp[i])
    }

    return dp[maxNum]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}