func findPeaks(mountain []int) []int {
	n := len(mountain)
	peaks := []int{}
	for i := 1; i < n-1; i++ {
		if mountain[i] > mountain[i-1] && mountain[i] > mountain[i+1] {
			peaks = append(peaks, i)
		}
	}
	return peaks
}