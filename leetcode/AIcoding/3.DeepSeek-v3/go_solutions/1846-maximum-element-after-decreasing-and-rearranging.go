func maximumElementAfterDecrementingAndRearranging(arr []int) int {
    sort.Ints(arr)
    n := len(arr)
    if arr[0] != 1 {
        arr[0] = 1
    }
    for i := 1; i < n; i++ {
        if arr[i] - arr[i-1] > 1 {
            arr[i] = arr[i-1] + 1
        }
    }
    return arr[n-1]
}