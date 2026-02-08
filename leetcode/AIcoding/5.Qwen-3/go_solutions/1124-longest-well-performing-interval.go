package main

func longestWellPerformingInterval(times []int) int {
    score := 0
    indexMap := make(map[int]int)
    indexMap[0] = -1
    maxLen := 0
    for i, t := range times {
        if t > 8 {
            score++
        } else {
            score--
        }
        if idx, ok := indexMap[score]; ok {
            maxLen = max(maxLen, i-idx)
        } else {
            indexMap[score] = i
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