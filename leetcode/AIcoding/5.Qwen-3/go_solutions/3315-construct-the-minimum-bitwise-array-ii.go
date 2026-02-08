package main

func minBitwiseArray(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = nums[i]
        for j := 0; j < i; j++ {
            if (res[j] | nums[i]) < res[i] {
                res[i] = res[j] | nums[i]
            }
        }
    }
    return res
}