func permute(nums []int) [][]int {
	result := [][]int{}
	var backtrack func(arr []int, used []bool, current []int)

	backtrack = func(arr []int, used []bool, current []int) {
		if len(current) == len(nums) {
			temp := make([]int, len(current))
			copy(temp, current)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(nums); i++ {
			if !used[i] {
				used[i] = true
				current = append(current, nums[i])
				backtrack(arr, used, current)
				current = current[:len(current)-1]
				used[i] = false
			}
		}
	}

	used := make([]bool, len(nums))
	backtrack(nums, used, []int{})
	return result
}