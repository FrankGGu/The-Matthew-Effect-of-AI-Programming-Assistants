func prisonAfterNDays(cells []int, n int) []int {
	seen := make(map[string]int)
	var history [][]int

	for i := 0; i < n; i++ {
		key := string(toInt8Slice(cells))
		if val, ok := seen[key]; ok {
			cycleLen := i - val
			remainingDays := (n - i) % cycleLen
			return history[val+remainingDays]
		}

		seen[key] = i
		history = append(history, copySlice(cells))

		nextCells := make([]int, len(cells))
		for j := 1; j < len(cells)-1; j++ {
			if cells[j-1] == cells[j+1] {
				nextCells[j] = 1
			} else {
				nextCells[j] = 0
			}
		}
		cells = nextCells
	}

	return cells
}

func toInt8Slice(arr []int) []int8 {
	result := make([]int8, len(arr))
	for i, v := range arr {
		result[i] = int8(v)
	}
	return result
}

func copySlice(arr []int) []int {
	result := make([]int, len(arr))
	copy(result, arr)
	return result
}