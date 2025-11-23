func countPartitions(nums []int) int {
    const mod = 1e9 + 7
    total := 0
    for _, num := range nums {
        total += num
    }
    if total % 2 != 0 {
        return 0
    }
    target := total / 2
    dp := make([]int, target+1)
    dp[0] = 1
    for _, num := range nums {
        for j := target; j >= num; j-- {
            dp[j] = (dp[j] + dp[j-num]) % mod
        }
    }
    return dp[target]
}