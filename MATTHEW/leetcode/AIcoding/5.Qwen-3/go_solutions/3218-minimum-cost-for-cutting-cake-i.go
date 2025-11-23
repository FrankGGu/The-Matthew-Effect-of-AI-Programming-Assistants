package main

func minCost(n int, m int, horizontalCuts []int, verticalCuts []int) int {
    sort.Ints(horizontalCuts)
    sort.Ints(verticalCuts)

    maxH := 0
    prev := 0
    for _, h := range horizontalCuts {
        maxH = max(maxH, h-prev)
        prev = h
    }
    maxH = max(maxH, n-prev)

    maxV := 0
    prev = 0
    for _, v := range verticalCuts {
        maxV = max(maxV, v-prev)
        prev = v
    }
    maxV = max(maxV, m-prev)

    return (maxH * maxV) % (1000000007)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}