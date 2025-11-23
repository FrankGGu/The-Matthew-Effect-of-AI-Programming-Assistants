package main

func minTimeToVisitAllPoints(x []int, y []int) int {
    time := 0
    for i := 1; i < len(x); i++ {
        dx := abs(x[i] - x[i-1])
        dy := abs(y[i] - y[i-1])
        time += max(dx, dy)
    }
    return time
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}