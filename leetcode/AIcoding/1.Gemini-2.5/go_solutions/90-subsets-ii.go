func subsetsWithDup(nums []int) [][]int {
	sort.Ints(nums)

	result := [][]int{}
	currentSubset := []int{}

	var backtrack func(start int)
	backtrack = func(start int) {
		temp := make([]int, len