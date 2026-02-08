func permute(nums []int) [][]int {
	var result [][]int
	n := len(nums)
	if n == 0 {
		return result
	}

	currentPermutation := make([]int, 0, n)
	visited := make([]bool, n)

	var backtrack func()
	backtrack = func() {
		if len(currentPermutation) == n {
			temp := make([]int, n)
			copy(temp, currentPermutation)
			result = append(result, temp)
			return
		}

		for i := 0; i < n; i++ {
			if !visited[i] {
				visited[i] = true
				currentPermutation = append(currentPermutation, nums[i])

				backtrack()

				currentPermutation = currentPermutation[:len(currentPermutation)-1]
				visited[i] = false
			}
		}
	}

	backtrack()
	return result
}