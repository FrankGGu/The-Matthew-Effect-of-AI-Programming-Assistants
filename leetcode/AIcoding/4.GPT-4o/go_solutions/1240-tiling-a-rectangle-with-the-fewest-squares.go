func tilingRectangle(n int, m int) int {
    dp := make([]int, 1<<uint(n*m))
    for i := range dp {
        dp[i] = n * m
    }
    dp[0] = 0

    for mask := 0; mask < 1<<uint(n*m); mask++ {
        x, y := 0, 0
        for y < n && (mask&(1<<uint(y*m))) != 0 {
            y++
        }
        for x = 0; x < m && (mask&(1<<uint(y*m+x))) != 0; x++ {
        }
        if x == m {
            continue
        }
        for size := 1; x+size <= m && y+size <= n; size++ {
            newMask := mask
            for a := 0; a < size; a++ {
                for b := 0; b < size; b++ {
                    newMask |= 1 << uint((y+b)*m+(x+a))
                }
            }
            dp[newMask] = min(dp[newMask], dp[mask]+1)
        }
    }
    return dp[(1<<uint(n*m))-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}