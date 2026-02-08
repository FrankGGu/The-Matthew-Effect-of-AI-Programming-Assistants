func minimumAbsDifference(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }

    m := len(matrix[0])
    if m == 0 {
        return 0
    }

    minDiff := math.MaxInt32
    for i := 0; i < n-1; i++ {
        for j := 0; j < m-1; j++ {
            a := matrix[i][j]
            b := matrix[i+1][j]
            c := matrix[i][j+1]
            d := matrix[i+1][j+1]
            diffs := []int{abs(a - b), abs(a - c), abs(a - d), abs(b - c), abs(b - d), abs(c - d)}
            for _, diff := range diffs {
                if diff < minDiff {
                    minDiff = diff
                }
            }
        }
    }

    return minDiff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}