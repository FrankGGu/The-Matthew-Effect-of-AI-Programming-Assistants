package main

func equalRowAndColumnPairs(matrix [][]int) int {
    rows := make(map[string]int)
    cols := make(map[string]int)

    n := len(matrix)

    for i := 0; i < n; i++ {
        row := ""
        for j := 0; j < n; j++ {
            row += strconv.Itoa(matrix[i][j]) + ","
        }
        rows[row]++
    }

    for j := 0; j < n; j++ {
        col := ""
        for i := 0; i < n; i++ {
            col += strconv.Itoa(matrix[i][j]) + ","
        }
        cols[col]++
    }

    count := 0
    for key, v := range rows {
        if c, ok := cols[key]; ok {
            count += v * c
        }
    }

    return count
}