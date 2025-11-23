func grayCode(n int) []int {
    result := make([]int, 1<<n)
    for i := 0; i < len(result); i++ {
        result[i] = i ^ (i >> 1)
    }
    return result
}