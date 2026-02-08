import (
	"sort"
)

func permuteUnique(nums []int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	currentPermutation := []int{}
	used := make([]bool, len(nums))

	var backtrack func()
	backtrack = func() {
		if len(currentPermutation) == len(nums) {
			temp := make([]int, len(currentPermutation))
			copy(temp, currentPermutation)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(nums); i++ {
			if used[i] {
				continue
			}
			// Skip duplicates
			// If the current number is the same as the previous one,
			// and the previous one was not used, it means we are trying to
			// form a permutation that would be identical to one formed if
			// we had used the previous duplicate number.
			// To avoid this, we skip the current number.
			// This condition is crucial for handling duplicates.
			if i > 0 && nums[i] == nums[i-1] && !used[i-1] {
				continue
			}

			used[i] = true
			currentPermutation = append(currentPermutation, nums[i])
			backtrack()
			currentPermutation = currentPermutation[:len(currentPermutation)-1]
			used[i] = false
		}
	}

	backtrack()
	return result
}