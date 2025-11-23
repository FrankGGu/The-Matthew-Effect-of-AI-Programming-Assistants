package main

func minimumCardPick(intervals []int) int {
    last := make(map[int]int)
    minLen := float64(1<<31 - 1)
    for i, v := range intervals {
        if prev, ok := last[v]; ok {
            minLen = min(minLen, float64(i-prev+1))
        }
        last[v] = i
    }
    if minLen == float64(1<<31 - 1) {
        return -1
    }
    return int(minLen)
}

func min(a, b float64) float64 {
    if a < b {
        return a
    }
    return b
}