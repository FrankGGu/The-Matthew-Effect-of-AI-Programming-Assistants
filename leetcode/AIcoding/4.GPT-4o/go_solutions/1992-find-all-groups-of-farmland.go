func findFarmland(land [][]int) [][]int {
    var result [][]int
    rows, cols := len(land), len(land[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if land[i][j] == 1 {
                startRow, startCol := i, j
                for i < rows && land[i][j] == 1 {
                    i++
                }
                for j < cols && land[startRow][j] == 1 {
                    j++
                }
                result = append(result, []int{startRow, startCol, i - 1, j - 1})
            }
        }
    }

    return result
}