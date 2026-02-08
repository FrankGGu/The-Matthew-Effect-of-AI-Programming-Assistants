package main

func minOperations(nums []int, k int) int {
    operations := 0
    for i := len(nums) - 1; i >= 0; i-- {
        if nums[i] < k {
            nums[i] += 1
            operations++
        }
        if i > 0 {
            nums[i-1] += nums[i]
        }
    }
    return operations
}