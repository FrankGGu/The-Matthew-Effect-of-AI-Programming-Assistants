func combinationSum(candidates []int, target int) [][]int {
    var result [][]int
    var current []int
    var backtrack func(start int, target int)

    backtrack = func(start int, target int) {
        if target == 0 {
            result = append(result, append([]int{}, current...))
            return
        }
        for i := start; i < len(candidates); i++ {
            if candidates[i] > target {
                continue
            }
            current = append(current, candidates[i])
            backtrack(i, target-candidates[i])
            current = current[:len(current)-1]
        }
    }

    backtrack(0, target)
    return result
}