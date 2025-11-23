package main

func longestSubarray(nums []int, k int) int {
    maxLen := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        increasing := true
        decreasing := true
        for j := i + 1; j < n; j++ {
            if nums[j] <= nums[j-1] {
                increasing = false
            }
            if nums[j] >= nums[j-1] {
                decreasing = false
            }
            if !increasing && !decreasing {
                break
            }
        }
        currentLen := 0
        if increasing || decreasing {
            currentLen = n - i
        } else {
            currentLen = 0
        }
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }
    return maxLen
}