const MOD = 1_000_000_007

func countSpecialSubsequences(nums []int) int {
    // dp[0]: count of subsequences ending with 0
    // dp[1]: count of subsequences ending with 01
    // dp[2]: count