package main

func minimumOperations(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        if nums[i] > k {
            res += (nums[i] - k + 1) / 2
        } else if nums[i] < k {
            res += (k - nums[i] + 1) / 2
        }
    }
    return res
}