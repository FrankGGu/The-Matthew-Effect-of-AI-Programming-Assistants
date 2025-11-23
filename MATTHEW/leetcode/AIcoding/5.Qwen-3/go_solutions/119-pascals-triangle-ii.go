package main

func getRow(rowIndex int) []int {
    row := make([]int, rowIndex+1)
    for i := 0; i <= rowIndex; i++ {
        row[i] = 1
        for j := i - 1; j > 0; j-- {
            row[j] = row[j] + row[j-1]
        }
    }
    return row
}