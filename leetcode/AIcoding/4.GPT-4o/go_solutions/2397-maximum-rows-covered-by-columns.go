func maximumRows(matrix [][]int, cols int) int {
    m, n := len(matrix), len(matrix[0])
    maxCovered := 0

    for mask := 0; mask < (1 << n); mask++ {
        if bits.OnesCount(uint(mask)) > cols {
            continue
        }

        covered := 0
        for i := 0; i < m; i++ {
            valid := true
            for j := 0; j < n; j++ {
                if matrix[i][j] == 1 && (mask&(1<<j)) == 0 {
                    valid = false
                    break
                }
            }
            if valid {
                covered++
            }
        }
        if covered > maxCovered {
            maxCovered = covered
        }
    }

    return maxCovered
}