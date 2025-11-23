package main

func sumDistance(nums []int, s string, k int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        if s[i] == 'L' {
            res[i] = nums[i] - k
        } else {
            res[i] = nums[i] + k
        }
    }
    return res
}