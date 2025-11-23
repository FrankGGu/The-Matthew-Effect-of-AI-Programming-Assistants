package main

func findShortestSubArray(nums []int) int {
    count := make(map[int]int)
    first := make(map[int]int)
    last := make(map[int]int)

    for i, num := range nums {
        count[num]++
        if _, ok := first[num]; !ok {
            first[num] = i
        }
        last[num] = i
    }

    minLength := len(nums)
    maxCount := 0

    for num, c := range count {
        if c > maxCount {
            maxCount = c
            minLength = last[num] - first[num] + 1
        } else if c == maxCount {
            minLength = min(minLength, last[num]-first[num]+1)
        }
    }

    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}