func grayCode(n int) []int {
    result := make([]int, 0)
    result = append(result, 0)
    for i := 0; i < n; i++ {
        size := len(result)
        for j := size - 1; j >= 0; j-- {
            result = append(result, result[j]|1<<i)
        }
    }
    return result
}