func maxManhattanDistance(A [][]int, K int) int {
    n := len(A)
    maxDist := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            for di := -1; di <= 1; di++ {
                for dj := -1; dj <= 1; dj++ {
                    if di*di+dj*dj > 0 {
                        x := i + di*K
                        y := j + dj*K
                        if x >= 0 && x < n && y >= 0 && y < n {
                            maxDist = max(maxDist, abs(A[i][j]-A[x][y])+abs(i-x)+abs(j-y))
                        }
                    }
                }
            }
        }
    }
    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}