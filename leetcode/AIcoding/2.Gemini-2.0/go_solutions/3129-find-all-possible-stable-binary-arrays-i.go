func findStableArrays(n int) [][]int {
	if n == 1 {
		return [][]int{{0}, {1}}
	}
	if n == 2 {
		return [][]int{{0, 0}, {0, 1}, {1, 0}, {1, 1}}
	}

	result := [][]int{}

	var backtrack func(index int, current []int)
	backtrack = func(index int, current []int) {
		if index == n {
			result = append(result, append([]int{}, current...))
			return
		}

		current[index] = 0
		if index == 0 || current[index-1] == 0 {
			backtrack(index+1, current)
		}

		current[index] = 1
		if index == 0 || current[index-1] == 1 {
			backtrack(index+1, current)
		}
	}

	current := make([]int, n)
	backtrack(0, current)

	return result
}