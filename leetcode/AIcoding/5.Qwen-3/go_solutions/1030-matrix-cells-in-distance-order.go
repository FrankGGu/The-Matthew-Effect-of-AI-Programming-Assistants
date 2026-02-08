package main

func allCellsInOrder(n int, m int) [][]int {
    result := make([][]int, 0, n*m)
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            result = append(result, []int{i, j})
        }
    }
    return result
}