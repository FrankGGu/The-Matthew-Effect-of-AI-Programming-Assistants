package main

func maximizeTheMinimumGameScore(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    left, right := 0, n-1
    res := 0
    for left < right {
        res = min(res, nums[left], nums[right])
        left++
        right--
    }
    return res
}

func min(a, b, c int) int {
    if a < b {
        if a < c {
            return a
        }
    } else {
        if b < c {
            return b
        }
    }
    return c
}