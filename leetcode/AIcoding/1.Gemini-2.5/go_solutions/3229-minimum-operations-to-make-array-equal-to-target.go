func minimumOperations(nums []int, target []int) int {
    n := len(nums)

    // dp[i] represents the difference target[i] - nums[i]
    // We want to make all dp[i] equal to 0.
    // An operation adds x to nums[k] for k in [