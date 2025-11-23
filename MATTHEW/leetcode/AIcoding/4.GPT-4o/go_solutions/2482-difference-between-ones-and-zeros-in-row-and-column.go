func matrixScore(A [][]int) int {
    m, n := len(A), len(A[0])

    for i := 0; i < m; i++ {
        if A[i][0] == 0 {
            for j := 0; j < n; j++ {
                A[i][j] ^= 1
            }
        }
    }

    for j := 0; j < n; j++ {
        count := 0
        for i := 0; i < m; i++ {
            if A[i][j] == 1 {
                count++
            }
        }
        if count < m/2 {
            for i := 0; i < m; i++ {
                A[i][j] ^= 1
            }
        }
    }

    score := 0
    for i := 0; i < m; i++ {
        num := 0
        for j := 0; j < n; j++ {
            num = num*2 + A[i][j]
        }
        score += num
    }

    return score
}