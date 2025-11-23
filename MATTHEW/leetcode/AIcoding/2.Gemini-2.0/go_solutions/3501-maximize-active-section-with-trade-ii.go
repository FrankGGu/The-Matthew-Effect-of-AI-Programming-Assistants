func maximizeActiveSection(charges []int, r int) int {
    n := len(charges)
    maxActive := 0
    for i := 0; i < n; i++ {
        active := 0
        for j := 0; j < n; j++ {
            if charges[j] > 0 && abs(j-i) <= r {
                active++
            }
        }
        maxActive = max(maxActive, active)
    }

    return maxActive
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