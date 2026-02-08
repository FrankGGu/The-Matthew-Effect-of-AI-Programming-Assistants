func sumSubarrayLengths(arr []int) int64 {
    n := len(arr)
    var total int64 = 0
    for i := 0; i < n; i++ {
        sum := 0
        for j := i; j < n; j++ {
            sum += arr[j]
            total += int64(sum)
        }
    }
    return total
}