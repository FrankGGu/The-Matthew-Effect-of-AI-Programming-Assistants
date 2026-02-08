func findPeaks(mountains []int) []int {
    var peaks []int
    n := len(mountains)

    if n < 3 {
        return peaks
    }

    for i := 1; i < n-1; i++ {
        if mountains[i] > mountains[i-1] && mountains[i] > mountains[i+1] {
            peaks = append(peaks, i)
        }
    }

    return peaks
}