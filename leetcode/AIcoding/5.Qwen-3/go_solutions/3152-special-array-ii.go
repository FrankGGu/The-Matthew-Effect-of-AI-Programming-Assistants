package main

func findArray(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = nums[i]
    }
    return res
}