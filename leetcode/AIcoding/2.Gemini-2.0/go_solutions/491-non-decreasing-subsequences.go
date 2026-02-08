func findSubsequences(nums []int) [][]int {
	result := [][]int{}
	set := make(map[string]bool)
	var backtrack func(index int, subsequence []int)
	backtrack = func(index int, subsequence []int) {
		if len(subsequence) >= 2 {
			key := ""
			for _, num := range subsequence {
				key += string(rune(num + 1000))
			}
			if !set[key] {
				result = append(result, append([]int{}, subsequence...))
				set[key] = true
			}
		}
		if index == len(nums) {
			return
		}
		if len(subsequence) == 0 || nums[index] >= subsequence[len(subsequence)-1] {
			backtrack(index+1, append(subsequence, nums[index]))
		}
		backtrack(index+1, subsequence)
	}
	backtrack(0, []int{})
	return result
}