package main

func minTime(heights []int) int {
    n := len(heights)
    if n == 0 {
        return 0
    }
    times := make([]int, n)
    for i := 1; i < n; i++ {
        if heights[i] > heights[i-1] {
            times[i] = times[i-1] + 1
        } else {
            times[i] = 0
        }
    }
    for i := n - 2; i >= 0; i-- {
        if heights[i] > heights[i+1] {
            times[i] = max(times[i], times[i+1]+1)
        }
    }
    maxTime := 0
    for _, t := range times {
        if t > maxTime {
            maxTime = t
        }
    }
    return maxTime
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}