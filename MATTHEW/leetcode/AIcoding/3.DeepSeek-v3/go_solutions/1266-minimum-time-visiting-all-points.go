func minTimeToVisitAllPoints(points [][]int) int {
    time := 0
    for i := 1; i < len(points); i++ {
        dx := abs(points[i][0] - points[i-1][0])
        dy := abs(points[i][1] - points[i-1][1])
        time += max(dx, dy)
    }
    return time
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}