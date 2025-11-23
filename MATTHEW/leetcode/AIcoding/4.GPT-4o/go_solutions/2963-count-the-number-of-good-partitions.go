func countPartitions(nums []int, k int) int {
    const mod = 1_000_000_007
    n := len(nums)
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    if totalSum < k {
        return 0
    }

    dp := make([]int, totalSum+1)
    dp[0] = 1

    for _, num := range nums {
        for j := totalSum; j >= num; j-- {
            dp[j] = (dp[j] + dp[j-num]) % mod
        }
    }

    result := 0
    for i := k; i <= totalSum; i++ {
        result = (result + dp[i]) % mod
    }

    return result
}