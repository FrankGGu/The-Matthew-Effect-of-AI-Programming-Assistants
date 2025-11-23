func hasAdjacentIncreasingSubarrays(arr []int) bool {
    n := len(arr)
    if n < 3 {
        return false
    }

    for i := 0; i < n-2; i++ {
        if arr[i] < arr[i+1] && arr[i+1] < arr[i+2] {
            return true
        }
    }

    return false
}