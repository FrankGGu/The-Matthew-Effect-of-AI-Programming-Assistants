func minOperations(nums []int) int {
    operations := 0
    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == 0 {
            operations++
            nums[i] ^= 1
            nums[i+1] ^= 1
        }
    }
    if nums[len(nums)-1] == 0 {
        return -1
    }
    return operations
}