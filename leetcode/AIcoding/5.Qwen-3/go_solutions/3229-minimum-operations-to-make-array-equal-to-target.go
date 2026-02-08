package main

func minOperations(nums []int, target []int) int {
    operations := 0
    carry := 0
    for i := 0; i < len(nums); i++ {
        current := nums[i] + carry
        if target[i] > current {
            operations += target[i] - current
            carry = 0
        } else if target[i] < current {
            carry = current - target[i]
        } else {
            carry = 0
        }
    }
    return operations
}