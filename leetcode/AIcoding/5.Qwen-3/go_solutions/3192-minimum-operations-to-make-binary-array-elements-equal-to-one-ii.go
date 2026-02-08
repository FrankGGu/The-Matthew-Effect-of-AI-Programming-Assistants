package main

func minOperations(nums []int, k int) int {
    n := len(nums)
    operations := 0
    flip := 0
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            flip ^= 1
            operations++
        }
        if i >= k-1 {
            if flip == 1 {
                nums[i-k+1] ^= 1
            }
        }
    }
    return operations
}