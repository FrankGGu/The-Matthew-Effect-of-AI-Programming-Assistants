func constructArray(original []int, m int, k int) []int {
    result := make([]int, 0)
    for i := 0; i < m; i++ {
        if i < k {
            result = append(result, original[i])
        } else {
            result = append(result, original[i-k])
        }
    }
    return result
}