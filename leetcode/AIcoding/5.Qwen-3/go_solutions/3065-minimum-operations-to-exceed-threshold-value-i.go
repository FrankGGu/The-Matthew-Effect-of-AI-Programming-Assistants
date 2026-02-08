package main

func minOperations(nums []int, k int) int {
    operations := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] < k {
            nums[i] += 1
            operations++
        }
    }
    return operations
}