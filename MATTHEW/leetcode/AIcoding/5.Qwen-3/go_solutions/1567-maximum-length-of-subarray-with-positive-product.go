package main

func maxSubArrayLen(nums []int, k int) int {
    sumMap := make(map[int]int)
    sumMap[0] = -1
    maxLen := 0
    currentSum := 0
    for i, num := range nums {
        currentSum += num
        if prevIndex, found := sumMap[currentSum-k]; found {
            maxLen = max(maxLen, i-prevIndex)
        }
        if _, found := sumMap[currentSum]; !found {
            sumMap[currentSum] = i
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