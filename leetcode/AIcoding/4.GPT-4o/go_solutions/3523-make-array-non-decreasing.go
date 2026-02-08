func minimumOperations(nums []int) int {
    operations := 0
    n := len(nums)

    for i := 1; i < n; i++ {
        if nums[i] < nums[i-1] {
            operations += nums[i-1] - nums[i]
            nums[i] = nums[i-1]
        }
    }

    return operations
}