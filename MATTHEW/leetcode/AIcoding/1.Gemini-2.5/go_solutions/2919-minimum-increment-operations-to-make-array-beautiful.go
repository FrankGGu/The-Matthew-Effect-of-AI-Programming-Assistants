package main

func minIncrementOperations(nums []int, k int) int64 {
    var operations int64 = 0
    for i := 1; i < len(nums); i++ {
        required := nums[i-1] + k
        if nums[i] < required {
            diff := required - nums[i]
            operations += int64(diff)
            nums[i] = required
        }
    }
    return operations
}