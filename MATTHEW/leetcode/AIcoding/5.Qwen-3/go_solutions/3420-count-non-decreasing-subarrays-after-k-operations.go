package main

func countSubarrays(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        prev := nums[i]
        res++
        for j := i + 1; j < n; j++ {
            if nums[j] >= prev {
                res++
                prev = nums[j]
            } else {
                break
            }
        }
    }
    return res
}