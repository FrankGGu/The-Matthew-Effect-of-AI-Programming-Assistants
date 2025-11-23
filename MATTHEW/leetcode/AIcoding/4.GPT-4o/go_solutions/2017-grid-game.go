func gridGame(grid [][]int) float64 {
    n := len(grid[0])
    topSum := make([]int, n)
    bottomSum := make([]int, n)

    for i := 0; i < n; i++ {
        topSum[i] = grid[0][i]
        bottomSum[i] = grid[1][i]
    }

    for i := 1; i < n; i++ {
        topSum[i] += topSum[i-1]
        bottomSum[i] += bottomSum[i-1]
    }

    minScore := math.MaxInt64
    for j := 0; j < n; j++ {
        top := 0
        if j > 0 {
            top = topSum[j-1]
        }
        bottom := 0
        if j < n-1 {
            bottom = bottomSum[n-1] - bottomSum[j]
        }
        minScore = min(minScore, top+bottom)
    }

    return float64(minScore) / 2.0
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}