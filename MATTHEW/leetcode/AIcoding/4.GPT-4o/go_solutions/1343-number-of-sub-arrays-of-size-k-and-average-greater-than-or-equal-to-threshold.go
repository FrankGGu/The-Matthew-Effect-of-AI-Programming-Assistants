func numOfSubarrays(arr []int, k int, threshold int) int {
    count := 0
    sum := 0
    n := len(arr)
    requiredSum := k * threshold

    for i := 0; i < n; i++ {
        sum += arr[i]
        if i >= k {
            sum -= arr[i-k]
        }
        if i >= k-1 && sum >= requiredSum {
            count++
        }
    }
    return count
}