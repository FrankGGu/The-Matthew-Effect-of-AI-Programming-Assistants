func sumOfSubarrays(arr []int) int64 {
    n := len(arr)
    totalSum := int64(0)

    for i := 0; i < n; i++ {
        totalSum += int64(arr[i]) * int64((i + 1) * (n - i))
    }

    return totalSum
}