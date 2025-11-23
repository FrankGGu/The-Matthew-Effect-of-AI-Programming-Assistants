package main

func sumMatrixAfterQueries(n int, queries [][]int) int {
    matrix := make([][]int, n)
    for i := range matrix {
        matrix[i] = make([]int, n)
    }

    for _, q := range queries {
        a, b, c, d := q[0], q[1], q[2], q[3]
        for i := a; i <= c; i++ {
            for j := b; j <= d; j++ {
                matrix[i][j]++
            }
        }
    }

    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            total += matrix[i][j]
        }
    }

    return total
}