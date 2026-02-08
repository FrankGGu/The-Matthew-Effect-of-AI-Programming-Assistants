package main

func minSubarrayLen(s int, nums []int) int {
    n := len(nums)
    left := 0
    currentSum := 0
    minLength := n + 1

    for right := 0; right < n; right++ {
        currentSum += nums[right]
        for currentSum >= s {
            minLength = min(minLength, right-left+1)
            currentSum -= nums[left]
            left++
        }
    }

    if minLength == n+1 {
        return 0
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}