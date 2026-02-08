func melt(data [][]int) [][]int {
    if len(data) == 0 || len(data[0]) == 0 {
        return [][]int{}
    }

    rows := len(data)
    cols := len(data[0])
    result := make([][]int, rows*cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            result[i*cols+j] = []int{i, data[i][j]}
        }
    }

    return result
}