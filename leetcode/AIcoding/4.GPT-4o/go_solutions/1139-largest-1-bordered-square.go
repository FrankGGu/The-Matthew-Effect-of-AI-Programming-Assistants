func largest1BorderedSquare(A [][]int) int {
    if len(A) == 0 || len(A[0]) == 0 {
        return 0
    }

    rows, cols := len(A), len(A[0])
    left := make([][]int, rows)
    top := make([][]int, rows)

    for i := range left {
        left[i] = make([]int, cols)
    }

    for j := range top {
        top[j] = make([]int, cols)
    }

    maxSize := 0

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if A[i][j] == 1 {
                left[i][j] = 1
                if j > 0 {
                    left[i][j] += left[i][j-1]
                }
                top[i][j] = 1
                if i > 0 {
                    top[i][j] += top[i-1][j]
                }

                minBorder := min(left[i][j], top[i][j])
                for k := minBorder; k > maxSize; k-- {
                    if i-k+1 >= 0 && j-k+1 >= 0 {
                        if left[i-k+1][j] >= k && top[i][j-k+1] >= k {
                            maxSize = k
                        }
                    }
                }
            }
        }
    }

    return maxSize * maxSize
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}