package main

func sumOfSubsequencePowers(nums []int, target int) int {
    mod := 1000000007
    dp := make(map[int]int)
    dp[0] = 1
    for _, num := range nums {
        newDp := make(map[int]int)
        for key, val := range dp {
            newDp[key] = (newDp[key] + val) % mod
            newKey := key + num
            newDp[newKey] = (newDp[newKey] + val) % mod
        }
        dp = newDp
    }
    return dp[target]
}