func constructArray(n int, m int) []int {
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = i + 1
    }
    for i := 0; i < m; i++ {
        result[i] = i + 1
    }
    return result
}