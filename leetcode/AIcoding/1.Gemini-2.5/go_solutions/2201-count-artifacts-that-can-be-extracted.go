func canBeExtracted(n int, artifacts [][]int, dig [][]int) int {
    isDug := make([][]bool, n)
    for i := 0; i < n; i++ {
        isDug[i] = make([]bool, n)
    }

    for _, d := range dig {
        r, c := d[0], d[1]
        isDug[r][c] = true
    }

    extractedCount := 0
    for _, artifact := range artifacts {
        r1, c1, r2, c2 := artifact[0], artifact[1], artifact[2], artifact[3]

        canExtract := true
        for r := r1; r <= r2; r++ {
            for c := c1; c <= c2; c++ {
                if !isDug[r][c] {
                    canExtract = false
                    break
                }
            }
            if !canExtract {
                break
            }
        }

        if canExtract {
            extractedCount++
        }
    }

    return extractedCount
}