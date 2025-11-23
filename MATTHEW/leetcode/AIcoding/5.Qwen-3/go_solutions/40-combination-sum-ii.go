package main

func combinationSum2(candidates []int, target int) [][]int {
    var result [][]int
    var path []int
    sort.Ints(candidates)
    var backtrack func(start int)
    backtrack = func(start int) {
        if target == 0 {
            result = append(result, append([]int{}, path...))
            return
        }
        for i := start; i < len(candidates); i++ {
            if i > start && candidates[i] == candidates[i-1] {
                continue
            }
            if candidates[i] > target {
                break
            }
            path = append(path, candidates[i])
            target -= candidates[i]
            backtrack(i + 1)
            target += candidates[i]
            path = path[:len(path)-1]
        }
    }
    backtrack(0)
    return result
}