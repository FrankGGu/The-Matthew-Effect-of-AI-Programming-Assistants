func isReachableAtTime(sx int, sy int, fx int, fy int, t int) bool {
    if sx == fx && sy == fy {
        return t != 1
    }
    dx := abs(fx - sx)
    dy := abs(fy - sy)
    maxDist := max(dx, dy)
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