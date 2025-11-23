func maxSelectedElements(nums []int) int {
    sort.Ints(nums)
    dp := make(map[int]int)
    maxLen := 0

    for _, num := range nums {
        dp[num+1] = dp[num] + 1
        dp[num] = dp[num-1] + 1
        if dp[num] > maxLen {
            maxLen = dp[num]
        }
        if dp[num+1] > maxLen {
            maxLen = dp[num+1]
        }
    }

    return maxLen
}