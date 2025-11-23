package main

func countSubmatrices(matrix [][]int, x int, y int) int {
    m := len(matrix)
    n := len(matrix[0])
    count := 0

    for i := 0; i < m; i++ {
        row := make([]int, n)
        for j := 0; j < n; j++ {
            row[j] = 0
        }
        for k := i; k < m; k++ {
            for j := 0; j < n; j++ {
                if matrix[k][j] == x {
                    row[j]++
                } else if matrix[k][j] == y {
                    row[j]--
                }
            }
            current := 0
            freq := make(map[int]int)
            freq[0] = 1
            for j := 0; j < n; j++ {
                current += row[j]
                count += freq[current]
                freq[current]++
            }
        }
    }
    return count
}