func minOperations(nums []int, k int) int {
    collected := make(map[int]bool)
    operations := 0
    for i := len(nums) - 1; i >= 0; i-- {
        operations++
        if nums[i] <= k {
            collected[nums[i]] = true
        }
        if len(collected) == k {
            break
        }
    }
    return operations
}