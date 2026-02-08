func permutationIV(nums []int) [][]int {
	result := [][]int{}
	var permute func(arr []int, used map[int]int, current []int)
	permute = func(arr []int, used map[int]int, current []int) {
		if len(current) == len(nums) {
			temp := make([]int, len(current))
			copy(temp, current)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(nums); i++ {
			if used[i] > 0 {
				continue
			}

			used[i]++
			permute(arr, used, append(current, nums[i]))
			used[i]--
		}
	}

	used := make(map[int]int)
	permute(nums, used, []int{})
	return result
}