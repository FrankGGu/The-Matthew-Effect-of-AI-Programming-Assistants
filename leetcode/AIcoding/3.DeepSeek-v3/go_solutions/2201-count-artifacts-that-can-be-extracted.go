func digArtifacts(n int, artifacts [][]int, dig [][]int) int {
    grid := make([][]bool, n)
    for i := range grid {
        grid[i] = make([]bool, n)
    }

    for _, d := range dig {
        grid[d[0]][d[1]] = true
    }

    count := 0
    for _, artifact := range artifacts {
        r1, c1, r2, c2 := artifact[0], artifact[1], artifact[2], artifact[3]
        allDug := true
        for i := r1; i <= r2; i++ {
            for j := c1; j <= c2; j++ {
                if !grid[i][j] {
                    allDug = false
                    break
                }
            }
            if !allDug {
                break
            }
        }
        if allDug {
            count++
        }
    }

    return count
}