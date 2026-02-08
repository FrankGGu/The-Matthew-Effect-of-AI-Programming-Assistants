package main

func countBeautifulSplits(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 1; i < n-1; i++ {
        left := 0
        right := 0
        for j := 0; j < i; j++ {
            left += nums[j]
        }
        for j := i; j < n; j++ {
            right += nums[j]
        }
        if left <= k && right <= k {
            res++
        }
    }
    return res
}