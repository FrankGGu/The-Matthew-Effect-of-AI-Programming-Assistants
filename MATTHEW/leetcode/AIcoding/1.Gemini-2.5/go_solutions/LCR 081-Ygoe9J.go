func combinationSum(candidates []int, target int) [][]int {
	var result [][]int
	var currentCombination []int

	// Sort candidates to help with pruning and ensuring combinations are in non-decreasing order
	// which implicitly handles avoiding duplicate combinations like [2,3] and [3,2]