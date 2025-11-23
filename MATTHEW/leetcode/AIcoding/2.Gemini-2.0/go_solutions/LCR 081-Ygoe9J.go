func combinationSum(candidates []int, target int) [][]int {
	result := [][]int{}
	var backtrack func(combination []int, remaining int, start int)

	backtrack = func(combination []int, remaining int, start int) {
		if remaining == 0 {
			temp := make([]int, len(combination))
			copy(temp, combination)
			result = append(result, temp)
			return
		}

		if remaining < 0 {
			return
		}

		for i := start; i < len(candidates); i++ {
			backtrack(append(combination, candidates[i]), remaining-candidates[i], i)
		}
	}

	backtrack([]int{}, target, 0)
	return result
}