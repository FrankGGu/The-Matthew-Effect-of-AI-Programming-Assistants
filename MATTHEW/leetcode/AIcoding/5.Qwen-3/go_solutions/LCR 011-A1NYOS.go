package main

func findMaxLength(nums []int) int {
    sumMap := make(map[int]int)
    sumMap[0] = -1
    maxLen := 0
    currentSum := 0

    for i, num := range nums {
        if num == 0 {
            currentSum--
        } else {
            currentSum++
        }

        if val, ok := sumMap[currentSum]; ok {
            maxLen = max(maxLen, i-val)
        } else {
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