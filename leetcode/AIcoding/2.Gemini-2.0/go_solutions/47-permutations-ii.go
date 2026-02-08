import "sort"

func permuteUnique(nums []int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	var backtrack func(arr []int, used []bool, permutation []int)
	backtrack = func(arr []int, used []bool, permutation []int) {
		if len(permutation) == len(nums) {
			temp := make([]int, len(permutation))
			copy(temp, permutation)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(arr); i++ {
			if used[i] || (i > 0 && arr[i] == arr[i-1] && !used[i-1]) {
				continue
			}

			used[i] = true
			backtrack(arr, used, append(permutation, arr[i]))
			used[i] = false
		}
	}

	used := make([]bool, len(nums))
	backtrack(nums, used, []int{})
	return result
}