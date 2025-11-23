package main

func coinChange(coins []int, amount int) int {
    dp := make([]int, amount+1)
    for i := 1; i <= amount; i++ {
        dp[i] = amount + 1
    }
    for i := 0; i < len(coins); i++ {
        for j := coins[i]; j <= amount; j++ {
            if dp[j-coins[i]]+1 < dp[j] {
                dp[j] = dp[j-coins[i]]+1
            }
        }
    }
    if dp[amount] == amount+1 {
        return -1
    }
    return dp[amount]
}