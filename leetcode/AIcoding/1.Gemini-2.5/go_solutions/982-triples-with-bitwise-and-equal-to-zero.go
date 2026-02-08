func triplesWithBitwiseANDEqualToZero(nums []int) int {
    maxVal := 1 << 16 // Max value for nums[i] is < 2^16

    // Step 1: Precompute counts for all possible (nums[i] & nums[j]) pairs
    // dp[mask] will store