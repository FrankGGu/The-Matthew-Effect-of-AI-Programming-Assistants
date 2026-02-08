func countTriplets(arr []int) int {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] ^ arr[i]
    }

    count := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j; k < n; k++ {
                a := prefix[j] ^ prefix[i]
                b := prefix[k+1] ^ prefix[j]
                if a == b {
                    count++
                }
            }
        }
    }
    return count
}