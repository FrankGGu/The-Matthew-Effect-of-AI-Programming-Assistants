func countCopyArrays(nums []int) int {
    mod := int(1e9 + 7)
    n := len(nums)
    dp := make([]int, n+1)
    dp[0] = 1

    for _, num := range nums {
        for j := n; j >= 1; j-- {
            if j <= num {
                dp[j] = (dp[j] + dp[j-1]) % mod
            }
        }
    }
    return dp[n]
}