package main

func isPeak(arr []int, i int) bool {
    if i > 0 && i < len(arr)-1 {
        return arr[i] > arr[i-1] && arr[i] > arr[i+1]
    }
    return false
}

func findPeaks(arr []int) []int {
    var peaks []int
    for i := 1; i < len(arr)-1; i++ {
        if isPeak(arr, i) {
            peaks = append(peaks, i)
        }
    }
    return peaks
}