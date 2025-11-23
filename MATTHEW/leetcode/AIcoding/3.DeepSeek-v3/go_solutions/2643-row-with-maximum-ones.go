func rowAndMaximumOnes(mat [][]int) []int {
    maxCount := -1
    maxRow := 0
    for i, row := range mat {
        count := 0
        for _, num := range row {
            if num == 1 {
                count++
            }
        }
        if count > maxCount || (count == maxCount && i < maxRow) {
            maxCount = count
            maxRow = i
        }
    }
    return []int{maxRow, maxCount}
}