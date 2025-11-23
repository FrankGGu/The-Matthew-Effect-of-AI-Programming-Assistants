package main

func minOperations(nums []int, k int) int {
    count := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] < k {
            nums[i] += 1
            count++
        }
    }
    return count
}