package main

func maximumBeauty(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    res := 0
    left := 0
    for right := 0; right < n; right++ {
        for nums[right] - nums[left] > 2*k {
            left++
        }
        res = max(res, right - left + 1)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}