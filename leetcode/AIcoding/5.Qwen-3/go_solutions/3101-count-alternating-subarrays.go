package main

func countAlternatingSubarrays(nums []int) int {
    n := len(nums)
    result := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if j == i || nums[j] != nums[j-1] {
                result++
            } else {
                break
            }
        }
    }
    return result
}