func minOperations(nums []int) int {
    operations := 0
    if len(nums) <= 1 {
        return 0
    }

    for i := 1; i < len(nums); i++ {
        if nums[i] <= nums[i-1] {
            incrementNeeded := nums[i-1] - nums[i] + 1
            operations += incrementNeeded
            nums[i] += incrementNeeded
        }
    }

    return operations
}