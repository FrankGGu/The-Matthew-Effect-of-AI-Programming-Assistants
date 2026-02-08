package main

func minOperations(nums []int, x int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    target := total - x
    if target < 0 {
        return -1
    }
    if target == 0 {
        return len(nums)
    }
    maxLen := -1
    left := 0
    currentSum := 0
    for right := 0; right < len(nums); right++ {
        currentSum += nums[right]
        for currentSum > target && left <= right {
            currentSum -= nums[left]
            left++
        }
        if currentSum == target {
            maxLen = max(maxLen, right-left+1)
        }
    }
    if maxLen == -1 {
        return -1
    }
    return len(nums) - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}