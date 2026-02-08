package main

func minSubArrayLen(s int, nums []int) int {
    left := 0
    currentSum := 0
    minLength := len(nums) + 1

    for right := 0; right < len(nums); right++ {
        currentSum += nums[right]
        for currentSum >= s {
            minLength = min(minLength, right-left+1)
            currentSum -= nums[left]
            left++
        }
    }

    if minLength > len(nums) {
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