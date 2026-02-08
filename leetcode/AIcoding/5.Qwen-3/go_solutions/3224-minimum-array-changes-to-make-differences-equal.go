package main

func minArrayChanges(nums []int, n int) int {
    res := 0
    for i := 1; i < n; i++ {
        if nums[i] < nums[i-1] {
            res += nums[i-1] - nums[i]
            nums[i] = nums[i-1]
        }
    }
    return res
}