package main

func rowWithMaximumones(mat [][]int) int {
    maxRow := 0
    maxCount := 0
    for i, row := range mat {
        count := 0
        for _, val := range row {
            if val == 1 {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
            maxRow = i
        }
    }
    return maxRow
}