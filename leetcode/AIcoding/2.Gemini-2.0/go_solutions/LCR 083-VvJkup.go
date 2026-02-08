func permute(nums []int) [][]int {
	result := [][]int{}
	var backtrack func(curr []int, remaining []int)

	backtrack = func(curr []int, remaining []int) {
		if len(remaining) == 0 {
			temp := make([]int, len(curr))
			copy(temp, curr)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(remaining); i++ {
			nextCurr := append(curr, remaining[i])
			nextRemaining := make([]int, 0)
			nextRemaining = append(nextRemaining, remaining[:i]...)
			nextRemaining = append(nextRemaining, remaining[i+1:]...)
			backtrack(nextCurr, nextRemaining)
		}
	}

	backtrack([]int{}, nums)
	return result
}