package main

func maximumRowsCovered(matrix [][]string, colIndices []int) int {
    rows := make(map[int]bool)
    for _, col := range colIndices {
        for i, row := range matrix {
            if row[col] == "1" {
                rows[i] = true
            }
        }
    }
    return len(rows)
}