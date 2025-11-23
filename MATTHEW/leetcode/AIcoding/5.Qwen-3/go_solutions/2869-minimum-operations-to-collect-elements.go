package main

func minOperations(nums []int, k int) int {
    n := len(nums)
    count := 0
    for i := n - 1; i >= 0; i-- {
        if nums[i] <= k {
            count++
            if count == k {
                break
            }
        }
    }
    return n - count
}