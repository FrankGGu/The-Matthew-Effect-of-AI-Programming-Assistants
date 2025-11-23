func combinationSum2(candidates []int, target int) [][]int {
	sort.Slice(candidates, func(i, j int) bool {
		return candidates[i] < candidates[j]
	})

	result := [][]int{}
	currentCombination := []int{}

	var backtrack func(start int, remainingTarget int)
	backtrack = func(start int, remainingTarget int) {
		if remainingTarget == 0 {
			temp := make([]int, len(currentCombination))
			copy(temp, currentCombination)
			result = append(result, temp)
			return
		}

		if remainingTarget < 0 {
			return
		}

		for i := start; i < len(candidates); i++ {
			// Skip duplicates
			if i > start && candidates[i] == candidates[i-1] {
				continue
			}

			// Optimization: if current candidate is greater than remaining target,
			// no further candidates (which are >= current) will work.
			if candidates[i] > remainingTarget {
				break
			}

			currentCombination = append(currentCombination, candidates[i])
			backtrack(i+1, remainingTarget-candidates[i]) // i+1 because each number can be used once
			currentCombination = currentCombination[:len(currentCombination)-1]
		}
	}

	backtrack(0, target)
	return result
}