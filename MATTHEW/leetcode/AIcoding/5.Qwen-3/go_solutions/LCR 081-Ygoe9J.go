package main

func combinationSum(candidates []int, target int) [][]int {
    result := [][]int{}
    var backtrack func(int, int, []int)
    backtrack = func(start int, remaining int, path []int) {
        if remaining == 0 {
            result = append(result, append([]int{}, path...))
            return
        }
        for i := start; i < len(candidates); i++ {
            if candidates[i] > remaining {
                continue
            }
            path = append(path, candidates[i])
            backtrack(i, remaining-candidates[i], path)
            path = path[:len(path)-1]
        }
    }
    backtrack(0, target, []int{})
    return result
}