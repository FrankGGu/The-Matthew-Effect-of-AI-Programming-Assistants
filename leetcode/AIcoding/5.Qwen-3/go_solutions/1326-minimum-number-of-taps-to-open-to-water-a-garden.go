package main

func minTaps(n int, ranges []int) int {
    // Convert the ranges into a jump array
    // For each position i, we can jump to i + ranges[i]
    // So we create an array where for each position i, we store the farthest point it can reach
    jump := make([]int, n+1)
    for i := 0; i <= n; i++ {
        jump[i] = i + ranges[i]
    }

    res := 0
    curEnd := 0
    nextEnd := 0

    for i := 0; i <= n; i++ {
        if i > curEnd {
            return -1
        }
        nextEnd = max(nextEnd, jump[i])
        if i == curEnd {
            res++
            curEnd = nextEnd
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}