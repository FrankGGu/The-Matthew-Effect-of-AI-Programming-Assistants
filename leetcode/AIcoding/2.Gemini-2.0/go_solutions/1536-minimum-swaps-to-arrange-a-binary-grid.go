func minSwaps(grid [][]int) int {
	n := len(grid)
	rights := make([]int, n)
	for i := 0; i < n; i++ {
		count := 0
		for j := n - 1; j >= 0; j-- {
			if grid[i][j] == 1 {
				break
			}
			count++
		}
		rights[i] = count
	}

	swaps := 0
	for i := 0; i < n; i++ {
		needed := n - 1 - i
		if rights[i] >= needed {
			continue
		}

		found := false
		for j := i + 1; j < n; j++ {
			if rights[j] >= needed {
				for k := j; k > i; k-- {
					rights[k], rights[k-1] = rights[k-1], rights[k]
					swaps++
				}
				found = true
				break
			}
		}

		if !found {
			return -1
		}
	}

	return swaps
}