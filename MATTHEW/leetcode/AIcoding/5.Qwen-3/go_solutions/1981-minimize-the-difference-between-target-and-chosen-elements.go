package main

func minimizeDifference(nums []int, target int) int {
    n := len(nums)
    dp := make([]bool, target+1)
    dp[0] = true
    for _, num := range nums {
        for i := target; i >= 0; i-- {
            if dp[i] && i+num <= target {
                dp[i+num] = true
            }
        }
    }
    for i := target; i >= 0; i-- {
        if dp[i] {
            return target - i
        }
    }
    return target - 0
}