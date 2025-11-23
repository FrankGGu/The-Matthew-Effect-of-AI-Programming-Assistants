package main

func maximizeSquareHoleArea(n int, k int, x []int, y []int) int {
    if k == 0 {
        return (n - 1) * (n - 1)
    }

    sort.Ints(x)
    sort.Ints(y)

    maxGapX := 0
    for i := 1; i < len(x); i++ {
        maxGapX = max(maxGapX, x[i]-x[i-1])
    }

    maxGapY := 0
    for i := 1; i < len(y); i++ {
        maxGapY = max(maxGapY, y[i]-y[i-1])
    }

    return (min(maxGapX, maxGapY) - 1) * (min(maxGapX, maxGapY) - 1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}