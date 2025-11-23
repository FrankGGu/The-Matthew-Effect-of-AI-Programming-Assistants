func minOperations(nums []int) int {
    operations := 0
    for i := 1; i < len(nums); i++ {
        if nums[i] <= nums[i-1] {
            diff := nums[i-1] - nums[i] + 1
            operations += diff
            nums[i] += diff
        }
    }
    return operations
}