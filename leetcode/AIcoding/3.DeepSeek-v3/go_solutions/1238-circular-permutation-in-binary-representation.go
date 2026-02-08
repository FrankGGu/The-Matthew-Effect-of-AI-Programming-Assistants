func circularPermutation(n int, start int) []int {
    res := make([]int, 1<<n)
    for i := 0; i < 1<<n; i++ {
        res[i] = start ^ i ^ (i >> 1)
    }
    return res
}