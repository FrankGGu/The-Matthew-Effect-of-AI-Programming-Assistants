package main

func findMaxLength(nums []int) int {
    countMap := make(map[int]int)
    countMap[0] = -1
    maxLen := 0
    count := 0
    for i, num := range nums {
        if num == 0 {
            count--
        } else {
            count++
        }
        if prev, ok := countMap[count]; ok {
            maxLen = max(maxLen, i-prev)
        } else {
            countMap[count] = i
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