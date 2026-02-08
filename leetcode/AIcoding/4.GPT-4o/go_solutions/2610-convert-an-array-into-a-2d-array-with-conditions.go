func convertArrayTo2D(arr []int, numRows int) [][]int {
    if len(arr) == 0 || numRows <= 0 {
        return [][]int{}
    }

    result := make([][]int, 0)
    rowSize := (len(arr) + numRows - 1) / numRows

    for i := 0; i < numRows; i++ {
        start := i * rowSize
        end := start + rowSize
        if start < len(arr) {
            if end > len(arr) {
                end = len(arr)
            }
            result = append(result, arr[start:end])
        }
    }

    return result
}