func xorQueries(arr []int, queries [][]int) []int {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] ^ arr[i]
    }
    result := make([]int, len(queries))
    for i, q := range queries {
        result[i] = prefix[q[1]+1] ^ prefix[q[0]]
    }
    return result
}