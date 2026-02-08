func minIncrements(arr []int, target []int) int {
    n := len(arr)
    count := 0
    for i := 0; i < n; i++ {
        if arr[i] < target[i] {
            count += target[i] - arr[i]
        }
    }
    return count
}