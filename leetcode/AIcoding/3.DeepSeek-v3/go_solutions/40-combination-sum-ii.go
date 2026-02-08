func combinationSum2(candidates []int, target int) [][]int {
    sort.Ints(candidates)
    var res [][]int
    var backtrack func(start int, path []int, sum int)

    backtrack = func(start int, path []int, sum int) {
        if sum == target {
            tmp := make([]int, len(path))
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        if sum > target {
            return
        }
        for i := start; i < len(candidates); i++ {
            if i > start && candidates[i] == candidates[i-1] {
                continue
            }
            path = append(path, candidates[i])
            backtrack(i+1, path, sum + candidates[i])
            path = path[:len(path)-1]
        }
    }

    backtrack(0, []int{}, 0)
    return res
}