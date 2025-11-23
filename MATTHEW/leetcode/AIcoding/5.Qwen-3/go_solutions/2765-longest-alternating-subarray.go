package main

func longestAlternatingSubarray(nums []int, limit int) int {
    n := len(nums)
    maxLen := 0
    for i := 0; i < n; i++ {
        currentLen := 1
        for j := i + 1; j < n; j++ {
            if (nums[j] - nums[j-1])*(nums[j-1] - nums[j-2]) < 0 {
                currentLen++
            } else {
                break
            }
        }
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }
    return maxLen
}