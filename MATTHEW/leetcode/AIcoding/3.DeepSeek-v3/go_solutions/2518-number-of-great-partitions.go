func countPartitions(nums []int, k int) int {
    const mod = 1e9 + 7
    total := 0
    for _, num := range nums {
        total += num
    }
    if total < 2 * k {
        return 0
    }
    n := len(nums)
    dp := make([]int, k)
    dp[0] = 1
    res := 1
    for i := 0; i < n; i++ {
        res = res * 2 % mod
        for j := k - 1; j >= nums[i]; j-- {
            dp[j] = (dp[j] + dp[j - nums[i]]) % mod
        }
    }
    sum := 0
    for j := 0; j < k; j++ {
        sum = (sum + dp[j]) % mod
    }
    return (res - 2 * sum % mod + mod) % mod
}