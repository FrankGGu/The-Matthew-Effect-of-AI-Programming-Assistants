func securityCheck(heights []int) int {
	n := len(heights)
	count := 0
	for i := 1; i < n-1; i++ {
		if heights[i] > heights[i-1] && heights[i] > heights[i+1] {
			count++
		}
	}
	return count
}