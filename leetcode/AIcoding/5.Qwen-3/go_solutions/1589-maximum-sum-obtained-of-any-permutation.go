package main

func maxSumAfterKChanges(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        if i < k {
            res += nums[i] * (i + 1)
        } else {
            res += nums[i] * (k + 1)
        }
    }
    return res
}