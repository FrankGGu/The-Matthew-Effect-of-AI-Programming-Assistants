func countTriplets(arr []int) int {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] ^ arr[i]
    }
    res := 0
    for i := 0; i < n; i++ {
        for k := i + 1; k < n; k++ {
            if prefix[i] == prefix[k+1] {
                res += k - i
            }
        }
    }
    return res
}