func findKthPositive(arr []int, k int) int {
    missingCount := 0
    current := 1
    index := 0

    for missingCount < k {
        if index < len(arr) && arr[index] == current {
            index++
        } else {
            missingCount++
        }
        current++
    }

    return current - 1
}