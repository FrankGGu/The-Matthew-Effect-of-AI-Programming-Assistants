package main

func maxSumSubsequence(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    if len(nums) == 1 {
        return nums[0]
    }
    prevPrev := nums[0]
    prev := max(nums[0], nums[1])
    for i := 2; i < len(nums); i++ {
        current := max(prev, prevPrev+nums[i])
        prevPrev, prev = prev, current
    }
    return prev
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}