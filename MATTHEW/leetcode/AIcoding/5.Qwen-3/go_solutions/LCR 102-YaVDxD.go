package main

func findTargetSumWays(nums []int, target int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if sum < target || (sum+target)%2 != 0 {
        return 0
    }
    n := (sum + target) / 2
    dp := make([]int, n+1)
    dp[0] = 1
    for _, num := range nums {
        for i := n; i >= num; i-- {
            dp[i] += dp[i-num]
        }
    }
    return dp[n]
}