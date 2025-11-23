import "sort"

func combinationSum2(candidates []int, target int) [][]int {
	sort.Ints(candidates)
	result := [][]int{}
	var backtrack func(combination []int, remaining int, start int)
	backtrack = func(combination []int, remaining int, start int) {
		if remaining == 0 {
			temp := make([]int, len(combination))
			copy(temp, combination)
			result = append(result, temp)
			return
		}
		if remaining < 0 {
			return
		}
		for i := start; i < len(candidates); i++ {
			if i > start && candidates[i] == candidates[i-1] {
				continue
			}
			backtrack(append(combination, candidates[i]), remaining-candidates[i], i+1)
		}
	}
	backtrack([]int{}, target, 0)
	return result
}