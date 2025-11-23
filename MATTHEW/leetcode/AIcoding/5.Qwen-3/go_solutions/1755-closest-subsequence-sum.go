package main

func minSubArrayLen(s int, nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    minLen := n + 1
    left := 0
    currentSum := 0
    for right := 0; right < n; right++ {
        currentSum += nums[right]
        for currentSum >= s {
            minLen = min(minLen, right-left+1)
            currentSum -= nums[left]
            left++
        }
    }
    if minLen > n {
        return 0
    }
    return minLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}