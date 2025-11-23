func peaksInArray(arr []int) []int {
    n := len(arr)
    peaks := []int{}

    for i := 1; i < n-1; i++ {
        if arr[i] > arr[i-1] && arr[i] > arr[i+1] {
            peaks = append(peaks, arr[i])
        }
    }

    return peaks
}