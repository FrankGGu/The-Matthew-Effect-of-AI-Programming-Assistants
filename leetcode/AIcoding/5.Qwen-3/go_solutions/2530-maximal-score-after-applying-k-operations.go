package main

func maxScore(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    res := 0
    for i := 0; i < k; i++ {
        res += nums[n - 1 - i]
    }
    return res
}