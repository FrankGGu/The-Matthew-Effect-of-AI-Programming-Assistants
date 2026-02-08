func countTriplets(arr []int) int {
    n := len(arr)
    count := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                if arr[i]^arr[j]^arr[k] == 0 {
                    count++
                }
            }
        }
    }
    return count
}