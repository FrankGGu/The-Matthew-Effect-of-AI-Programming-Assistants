func longestUnequalAdjacentGroups(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([][2]int, n)
    dp[0][0] = 1
    dp[0][1] = 1

    for i := 1; i < n; i++ {
        dp[i][0] = 1
        dp[i][1] = 1
        for j := 0; j < i; j++ {
            if nums[i] != nums[j] {
                dp[i][0] = max(dp[i][0], dp[j][1] + 1)
                dp[i][1] = max(dp[i][1], dp[j][0] + 1)
            }
        }
    }

    maxLength := 0
    for i := 0; i < n; i++ {
        maxLength = max(maxLength, max(dp[i][0], dp[i][1]))
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}