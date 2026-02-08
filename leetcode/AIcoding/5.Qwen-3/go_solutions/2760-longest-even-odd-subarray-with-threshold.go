package main

func longestAlternatingSubarray(nums []int, threshold int) int {
    n := len(nums)
    maxLen := 0

    for i := 0; i < n; i++ {
        if nums[i] > threshold {
            continue
        }
        currentLen := 1
        maxLen = max(maxLen, currentLen)
        for j := i + 1; j < n; j++ {
            if nums[j] > threshold {
                break
            }
            if (nums[j-1] % 2 == 0 && nums[j] % 2 == 1) || (nums[j-1] % 2 == 1 && nums[j] % 2 == 0) {
                currentLen++
                maxLen = max(maxLen, currentLen)
            } else {
                break
            }
        }
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}