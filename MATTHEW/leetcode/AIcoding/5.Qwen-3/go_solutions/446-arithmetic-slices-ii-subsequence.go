package main

func numberOfArithmeticSlices(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    dp := make([]map[int]int, n)
    for i := range dp {
        dp[i] = make(map[int]int)
    }

    result := 0

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            diff := nums[i] - nums[j]
            count := dp[j][diff]
            dp[i][diff] += count + 1
            result += count
        }
    }

    return result
}