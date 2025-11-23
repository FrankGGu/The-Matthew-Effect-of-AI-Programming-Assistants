func makeStringEmpty(s string) string {
	n := len(s)
	lastOccurrence := make(map[rune]int)
	for i, r := range s {
		lastOccurrence[r] = i
	}

	bit := make([]int, n+1)

	update := func(i int, val int) {
		i++
		for i <= n {
			bit[i] += val
			i += i & -i
		}
	}

	query := func(i int) int {
		sum := 0
		i++
		for i > 0 {
			sum += bit[i]
			i -= i & -i
		}
		return sum
	}

	result := []rune{}
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	for i := 0; i < n; i++ {
		update(i, 1)
	}

	for i := 0; i < n; i++ {
		minIdx := -1
		for j := 0; j < len(indices); j++ {
			if query(indices[j]) - query(indices[j]-1) > 0 {
				if minIdx == -1 || indices[j] < indices[minIdx] {
					minIdx = j
				}
			}
		}

		idxToRemove := indices[minIdx]

		result = append(result, rune(s[idxToRemove]))
		update(idxToRemove, -1)

		newIndices := []int{}
		for j := 0; j < len(indices); j++ {
			if indices[j] != idxToRemove {
				newIndices = append(newIndices, indices[j])
			}
		}
		indices = newIndices

		if lastOccurrence[rune(s[idxToRemove])] > idxToRemove {
			toRemove := -1
			for j := 0; j < len(indices); j++ {
				if indices[j] > idxToRemove && lastOccurrence[rune(s[idxToRemove])] == indices[j]{
					toRemove = j
					break
				}
			}

			if toRemove != -1{
				idxToRemove2 := indices[toRemove]
				update(idxToRemove2, -1)
				newIndices2 := []int{}
				for j := 0; j < len(indices); j++ {
					if indices[j] != idxToRemove2 {
						newIndices2 = append(newIndices2, indices[j])
					}
				}
				indices = newIndices2
			}
		}

	}

	return string(result)
}