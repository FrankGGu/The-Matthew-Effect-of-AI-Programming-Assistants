func countPartitions(nums []int, k int) int {
    n := len(nums)
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    if totalSum < k || (totalSum-k)%2 != 0 {
        return 0
    }

    target := (totalSum - k) / 2
    mod := 1_000_000_007
    dp := make([]int, target+1)
    dp[0] = 1

    for _, num := range nums {
        for j := target; j >= num; j-- {
            dp[j] = (dp[j] + dp[j-num]) % mod
        }
    }

    return dp[target]
}