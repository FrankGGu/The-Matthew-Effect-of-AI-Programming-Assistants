package main

func findGoodSubset(matrix [][]int) []int {
    n := len(matrix)
    m := len(matrix[0])
    result := make([]int, 0, n)
    for i := 0; i < n; i++ {
        if matrix[i][0] == 1 {
            result = append(result, i)
        }
    }
    return result
}