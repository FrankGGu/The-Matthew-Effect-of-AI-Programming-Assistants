func countBlackBlocks(m int64, n int64, coordinates [][]int) []int64 {
	count := make(map[int64]int64)
	total := int64(0)

	for _, coord := range coordinates {
		x := int64(coord[0])
		y := int64(coord[1])

		for i := max(1, x) - 1; i <= min(m-1, x); i++ {
			for j := max(1, y) - 1; j <= min(n-1, y); j++ {
				key := i*(n-1) + j
				count[key]++
			}
		}
	}

	result := make([]int64, 5)
	for _, c := range count {
		result[c]++
		total++
	}

	result[0] = (m-1)*(n-1) - total
	return result
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}