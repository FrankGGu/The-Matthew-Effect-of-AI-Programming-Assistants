package main

func maxSumDivThree(nums []int) int {
    dp := []int{0, -1, -1}
    for _, num := range nums {
        for i := 2; i >= 0; i-- {
            if dp[i] != -1 {
                remainder := (dp[i] + num) % 3
                if dp[remainder] < dp[i]+num {
                    dp[remainder] = dp[i] + num
                }
            }
        }
    }
    return dp[0]
}