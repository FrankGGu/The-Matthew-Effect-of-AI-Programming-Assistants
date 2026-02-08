func bestLocation(positions [][]int, r int) []int {
    n := len(positions)
    minDist := math.MaxInt32
    bestPos := []int{-1, -1}

    for i := 0; i < n; i++ {
        x, y := positions[i][0], positions[i][1]
        totalDist := 0

        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            dist := abs(x-positions[j][0]) + abs(y-positions[j][1])
            totalDist += (dist + r - 1) / r
        }

        if totalDist < minDist {
            minDist = totalDist
            bestPos = []int{x, y}
        }
    }

    return bestPos
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}