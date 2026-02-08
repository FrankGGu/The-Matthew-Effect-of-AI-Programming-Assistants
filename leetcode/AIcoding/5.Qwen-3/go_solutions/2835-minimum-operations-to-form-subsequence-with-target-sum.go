package main

func minOperations(nums []int, target int) int {
    operations := 0
    carry := 0
    for i := 0; i < len(nums); i++ {
        carry += nums[i]
        if carry >= target {
            carry -= target
            target = 0
            break
        }
        target >>= 1
        carry >>= 1
    }
    if target > 0 {
        return -1
    }
    return operations
}