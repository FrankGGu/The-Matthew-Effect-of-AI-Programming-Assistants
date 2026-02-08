package main

func minOperations(nums []int) int {
    operations := 0
    flip := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] ^ flip == 0 {
            operations++
            flip ^= 1
        }
    }
    return operations
}