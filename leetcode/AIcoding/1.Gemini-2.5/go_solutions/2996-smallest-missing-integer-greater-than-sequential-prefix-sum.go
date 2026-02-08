func missingInteger(nums []int) int {
    if len(nums) == 0 {
        return 1 // According to constraints, nums.length >= 1, so this case won't occur.
    }

    // Calculate the sum of the longest sequential prefix
    prefixSum := nums[0]
    for i := 1;