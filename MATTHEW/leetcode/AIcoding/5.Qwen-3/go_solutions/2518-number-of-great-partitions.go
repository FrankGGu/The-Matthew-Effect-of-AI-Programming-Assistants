package main

func countGreatPartitions(nums []int) int {
    mod := 1000000007
    n := len(nums)
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    dp := make([]int, totalSum+1)
    dp[0] = 1
    for _, num := range nums {
        for i := totalSum; i >= num; i-- {
            dp[i] = (dp[i] + dp[i-num]) % mod
        }
    }

    result := 0
    for i := 1; i < totalSum; i++ {
        if dp[i] > 0 {
            result = (result + dp[i]) % mod
        }
    }

    return result
}