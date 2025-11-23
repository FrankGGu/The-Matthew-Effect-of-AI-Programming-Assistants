package main

func combinationSum(candidates []int, target int) [][]int {
    result := [][]int{}
    var backtrack func(start int, path []int, remaining int)
    backtrack = func(start int, path []int, remaining int) {
        if remaining == 0 {
            result = append(result, append([]int{}, path...))
            return
        }
        for i := start; i < len(candidates); i++ {
            if candidates[i] > remaining {
                continue
            }
            path = append(path, candidates[i])
            backtrack(i, path, remaining-candidates[i])
            path = path[:len(path)-1]
        }
    }
    backtrack(0, []int{}, target)
    return result
}