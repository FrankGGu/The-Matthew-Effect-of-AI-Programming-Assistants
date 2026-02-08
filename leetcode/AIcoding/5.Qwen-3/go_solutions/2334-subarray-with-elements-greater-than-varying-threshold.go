package main

func numOfSubarrays(nums []int, k int, threshold int) int {
    n := len(nums)
    res := 0
    sum := 0
    for i := 0; i < k; i++ {
        sum += nums[i]
    }
    if sum/k >= threshold {
        res++
    }
    for i := k; i < n; i++ {
        sum += nums[i] - nums[i-k]
        if sum/k >= threshold {
            res++
        }
    }
    return res
}