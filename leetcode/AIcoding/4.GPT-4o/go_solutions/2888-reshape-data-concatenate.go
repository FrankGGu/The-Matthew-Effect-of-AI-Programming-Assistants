func reshapeData(mat [][]int, r int, c int) [][]int {
    flat := []int{}
    for _, row := range mat {
        flat = append(flat, row...)
    }
    if len(flat) != r*c {
        return mat
    }
    reshaped := make([][]int, r)
    for i := 0; i < r; i++ {
        reshaped[i] = flat[i*c : (i+1)*c]
    }
    return reshaped
}