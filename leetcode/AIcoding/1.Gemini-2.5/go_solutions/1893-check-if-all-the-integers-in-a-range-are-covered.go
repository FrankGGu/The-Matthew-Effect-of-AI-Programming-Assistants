func isCovered(ranges [][]int, left int, right int) bool {
	covered := make([]bool, 51) // Max value for right is 50, so index 50 is needed. Size 51 for 0-50.

	for _, r := range ranges {
		start := r[0]
		end := r[1]
		for i := start; i <= end; i++ {
			if i >= left && i <= right {
				covered[i] = true
			}
		}
	}

	for i := left; i <= right; i++ {
		if !covered[i] {
			return false
		}
	}

	return true
}