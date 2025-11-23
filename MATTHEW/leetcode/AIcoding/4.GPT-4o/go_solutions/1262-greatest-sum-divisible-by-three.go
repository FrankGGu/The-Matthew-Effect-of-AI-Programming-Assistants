func maxSumDivThree(nums []int) int {
    dp := []int{0, 0, 0}
    for _, num := range nums {
        dpTemp := make([]int, 3)
        for i := 0; i < 3; i++ {
            dpTemp[(i+num)%3] = max(dpTemp[(i+num)%3], dp[i]+num)
        }
        for i := 0; i < 3; i++ {
            dpTemp[i] = max(dpTemp[i], dp[i])
        }
        dp = dpTemp
    }
    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}