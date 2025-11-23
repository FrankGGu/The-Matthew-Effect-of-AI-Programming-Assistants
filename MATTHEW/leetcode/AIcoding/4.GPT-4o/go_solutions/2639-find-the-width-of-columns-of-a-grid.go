func findColumnWidth(matrix [][]string) []int {
    if len(matrix) == 0 {
        return []int{}
    }
    cols := len(matrix[0])
    widths := make([]int, cols)

    for _, row := range matrix {
        for j, val := range row {
            if len(val) > widths[j] {
                widths[j] = len(val)
            }
        }
    }

    return widths
}