func decode(encoded []int, first int) []int {
    n := len(encoded)
    arr := make([]int, n+1)
    arr[0] = first
    for i := 0; i < n; i++ {
        arr[i+1] = arr[i] ^ encoded[i]
    }
    return arr
}