import "sort"

func combinationSum2(candidates []int, target int) [][]int {
	sort.Ints(candidates)

	var results [][]int
	var currentCombination []int

	var backtrack func(start int, currentTarget int)
	backtrack = func(start int, currentTarget int) {
		if current