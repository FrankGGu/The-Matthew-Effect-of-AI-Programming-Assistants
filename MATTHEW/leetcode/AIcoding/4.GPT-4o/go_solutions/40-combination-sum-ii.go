func combinationSum2(candidates []int, target int) [][]int {
    var result [][]int
    sort.Ints(candidates)
    backtrack(candidates, target, []int{}, &result, 0)
    return result
}

func backtrack(candidates []int, target int, current []int, result *[][]int, start int) {
    if target == 0 {
        combination := make([]int, len(current))
        copy(combination, current)
        *result = append(*result, combination)
        return
    }
    for i := start; i < len(candidates); i++ {
        if i > start && candidates[i] == candidates[i-1] {
            continue
        }
        if candidates[i] > target {
            break
        }
        current = append(current, candidates[i])
        backtrack(candidates, target-candidates[i], current, result, i+1)
        current = current[:len(current)-1]
    }
}