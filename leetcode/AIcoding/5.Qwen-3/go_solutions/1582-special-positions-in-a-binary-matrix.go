package main

func numSpecial(matrix [][]int) int {
    rows := make([]int, len(matrix))
    cols := make([]int, len(matrix[0]))

    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] == 1 {
                rows[i]++
                cols[j]++
            }
        }
    }

    count := 0
    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] == 1 && rows[i] == 1 && cols[j] == 1 {
                count++
            }
        }
    }

    return count
}