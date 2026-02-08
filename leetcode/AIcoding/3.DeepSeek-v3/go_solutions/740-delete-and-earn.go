func deleteAndEarn(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }
    points := make([]int, maxNum+1)
    for _, num := range nums {
        points[num] += num
    }
    dp := make([]int, maxNum+1)
    dp[0] = points[0]
    if maxNum >= 1 {
        dp[1] = max(points[0], points[1])
    }
    for i := 2; i <= maxNum; i++ {
        dp[i] = max(dp[i-1], dp[i-2]+points[i])
    }
    return dp[maxNum]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}