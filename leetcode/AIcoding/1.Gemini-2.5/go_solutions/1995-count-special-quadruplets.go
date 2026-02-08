func countQuadruplets(nums []int) int {
    n := len(nums)
    count := 0

    // Optimization: Use a frequency map for nums[d] - nums[c]
    // Iterate d from right to left (n-1 down to 3)
    // For each d, iterate c from d-1