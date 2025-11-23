func isReachableAtTime(sx int, sy int, fx int, fy int, t int) bool {
    dx := abs(sx - fx)
    dy := abs(sy - fy)
    maxDist := max(dx, dy)
    if maxDist == 0 {
        return t != 1
    }
    return t >= maxDist
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