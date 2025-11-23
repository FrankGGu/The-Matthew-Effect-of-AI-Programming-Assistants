package main

func countSubarrays(nums []int, k int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        var max, min int
        max = nums[i]
        min = nums[i]
        for j := i; j < n; j++ {
            max = max(max, nums[j])
            min = min(min, nums[j])
            if max - min < k {
                count++
            } else {
                break
            }
        }
    }
    return count
}