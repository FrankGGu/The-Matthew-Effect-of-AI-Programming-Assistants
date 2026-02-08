func numOfSubarrays(arr []int, k int, threshold int) int {
    sum := 0
    count := 0
    target := k * threshold

    for i := 0; i < k; i++ {
        sum += arr[i]
    }

    if sum >= target {
        count++
    }

    for i := k; i < len(arr); i++ {
        sum += arr[i] - arr[i-k]
        if sum >= target {
            count++
        }
    }

    return count
}