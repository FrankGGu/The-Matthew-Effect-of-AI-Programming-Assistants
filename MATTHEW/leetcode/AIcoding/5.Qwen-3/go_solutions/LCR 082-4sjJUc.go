package main

func combinationSum2(candidates []int, target int) [][]int {
    var result [][]int
    var path []int
    sort.Ints(candidates)
    var backtrack func(start int)
    backtrack = func(start int) {
        if target == 0 {
            temp := make([]int, len(path))
            copy(temp, path)
            result = append(result, temp)
            return
        }
        for i := start; i < len(candidates); i++ {
            if i > start && candidates[i] == candidates[i-1] {
                continue
            }
            if candidates[i] > target {
                break
            }
            target -= candidates[i]
            path = append(path, candidates[i])
            backtrack(i + 1)
            path = path[:len(path)-1]
            target += candidates[i]
        }
    }
    backtrack(0)
    return result
}