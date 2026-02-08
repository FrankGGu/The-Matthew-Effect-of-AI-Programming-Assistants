package main

func minOperations(nums []int) int {
    operations := 0
    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            continue
        }
        operations += nums[i-1] - nums[i] + 1
        nums[i] = nums[i-1] + 1
    }
    return operations
}