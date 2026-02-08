func maximumOnes(mat [][]int) []int {
    maxCount := 0
    rowIndex := -1
    for i, row := range mat {
        count := 0
        for _, val := range row {
            if val == 1 {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
            rowIndex = i
        }
    }
    return []int{rowIndex, maxCount}
}