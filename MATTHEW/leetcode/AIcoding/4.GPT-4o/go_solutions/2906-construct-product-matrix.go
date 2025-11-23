func construct2DArray(original []int, m int, n int) [][]int {
    if m*n != len(original) {
        return [][]int{}
    }
    result := make([][]int, m)
    for i := 0; i < m; i++ {
        result[i] = original[i*n : (i+1)*n]
    }
    return result
}