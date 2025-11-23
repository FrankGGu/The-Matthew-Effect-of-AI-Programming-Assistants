func numberOfArithmeticSlices(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    count := 0
    dp := make([]map[int]int, n)

    for i := 0; i < n; i++ {
        dp[i] = make(map[int]int)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            diff := nums[i] - nums[j]
            if countJ, ok := dp[j][diff]; ok {
                dp[i][diff] += countJ + 1
                count += countJ
            }
            dp[i][diff]++
        }
    }

    return count
}