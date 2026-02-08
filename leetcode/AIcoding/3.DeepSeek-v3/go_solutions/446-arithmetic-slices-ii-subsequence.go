func numberOfArithmeticSlices(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    dp := make([]map[int]int, n)
    for i := range dp {
        dp[i] = make(map[int]int)
    }

    res := 0

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            diff := nums[i] - nums[j]
            cnt := dp[j][diff]
            res += cnt
            dp[i][diff] += cnt + 1
        }
    }

    return res
}