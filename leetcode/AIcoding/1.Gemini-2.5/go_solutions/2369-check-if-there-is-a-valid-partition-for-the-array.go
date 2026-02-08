func isValidPartition(nums []int) bool {
    n := len(nums)
    dp := make([]bool, n+1)
    dp[0] = true // Base case: an empty prefix is considered validly partitioned

    for i := 1; i <= n; i++ {
        // Option 1: Check