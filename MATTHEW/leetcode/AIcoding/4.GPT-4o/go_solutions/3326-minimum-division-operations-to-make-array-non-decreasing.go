func minOperations(nums []int) int {
    n := len(nums)
    ops := 0
    for i := 1; i < n; i++ {
        if nums[i] < nums[i-1] {
            ops += nums[i-1] - nums[i]
            nums[i] = nums[i-1]
        }
    }
    return ops
}