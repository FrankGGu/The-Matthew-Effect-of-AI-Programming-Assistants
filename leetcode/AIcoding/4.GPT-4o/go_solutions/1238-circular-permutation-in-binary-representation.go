func circularPermutation(n int, start int) []int {
    result := make([]int, 1 << n)
    for i := 0; i < len(result); i++ {
        result[i] = i ^ (i >> 1)
    }
    startIndex := 0
    for i := 0; i < len(result); i++ {
        if result[i] == start {
            startIndex = i
            break
        }
    }
    return append(result[startIndex:], result[:startIndex]...)
}