package main

func construct2DGrid(photos [][]int, capacity []int) [][]int {
    var result [][]int
    for i := 0; i < len(photos); i++ {
        row := make([]int, 0, capacity[i])
        for j := 0; j < len(photos[i]); j++ {
            row = append(row, photos[i][j])
        }
        result = append(result, row)
    }
    return result
}