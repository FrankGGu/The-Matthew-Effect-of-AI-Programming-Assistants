func toyCount(radii []int, k int) int {
	n := len(radii)
	count := 0
	for i := 0; i < n; i++ {
		if radii[i] <= k {
			count++
		}
	}
	return count
}