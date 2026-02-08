func permute(nums []int) [][]int {
	var result [][]int
	n := len(nums)
	if n == 0 {
		return result
	}

	currentPermutation := make([]int, 0, n)
	used := make([]bool, n)

	var backtrack func()
	backtrack = func() {
		if len(currentPermutation) == n {
			temp := make([]int, n)
			copy(temp, currentPermutation)
			result = append(result, temp)
			return
		}

		for i := 0; i < n; i++ {
			if !used[i] {
				used[i] = true
				currentPermutation = append(currentPermutation, nums[i])
				backtrack()
				currentPermutation = currentPermutation[:len(currentPermutation)-1]
				used[i] = false
			}
		}
	}

	backtrack()
	return result
}