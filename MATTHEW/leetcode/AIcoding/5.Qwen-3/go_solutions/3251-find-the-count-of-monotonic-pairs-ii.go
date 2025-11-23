package main

func countMonotonicPairs(nums []int) int {
    const MOD = 1000000007
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if nums[j] <= nums[i] {
                dp[i] = (dp[i] + dp[j]) % MOD
            }
        }
    }
    result := 0
    for _, v := range dp {
        result = (result + v) % MOD
    }
    return result
}