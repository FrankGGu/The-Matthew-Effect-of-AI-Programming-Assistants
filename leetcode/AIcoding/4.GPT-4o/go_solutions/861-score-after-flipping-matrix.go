func matrixScore(A [][]int) int {
    m, n := len(A), len(A[0])
    score := 0

    for j := 0; j < n; j++ {
        ones := 0
        for i := 0; i < m; i++ {
            if A[i][0] == 1 {
                ones += A[i][j]
            } else {
                ones += 1 - A[i][j]
            }
        }
        if ones < m/2 {
            ones = m - ones
        }
        score += ones * (1 << (n - j - 1))
    }

    return score
}