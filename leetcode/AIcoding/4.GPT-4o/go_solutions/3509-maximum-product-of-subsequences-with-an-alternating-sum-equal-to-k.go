func maxProduct(nums []int, k int) int {
    n := len(nums)
    mod := 1_000_000_007
    dp := make([]int, k+1)
    dp[0] = 1

    for _, num := range nums {
        for j := k; j >= num; j-- {
            dp[j] = (dp[j] + dp[j-num]) % mod
        }
    }

    return dp[k]
}