func sumOddLengthSubarrays(arr []int) int {
    n := len(arr)
    total := 0
    for l := 1; l <= n; l += 2 {
        for i := 0; i <= n-l; i++ {
            for j := i; j < i+l; j++ {
                total += arr[j]
            }
        }
    }
    return total
}