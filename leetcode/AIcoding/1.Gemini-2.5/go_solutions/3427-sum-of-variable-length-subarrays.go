func sumOfVariableLengthSubarrays(arr []int) int {
    totalSum := 0
    n := len(arr)
    for i := 0; i < n; i++ {
        totalSum += arr[i] * (i + 1) * (n - i)
    }
    return totalSum
}