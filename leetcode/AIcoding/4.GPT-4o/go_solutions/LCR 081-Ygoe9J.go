func combinationSum(candidates []int, target int) [][]int {
    var res [][]int
    var path []int

    var backtrack func(start int, target int)
    backtrack = func(start int, target int) {
        if target == 0 {
            temp := make([]int, len(path))
            copy(temp, path)
            res = append(res, temp)
            return
        }
        for i := start; i < len(candidates); i++ {
            if candidates[i] > target {
                continue
            }
            path = append(path, candidates[i])
            backtrack(i, target-candidates[i])
            path = path[:len(path)-1]
        }
    }

    backtrack(0, target)
    return res
}