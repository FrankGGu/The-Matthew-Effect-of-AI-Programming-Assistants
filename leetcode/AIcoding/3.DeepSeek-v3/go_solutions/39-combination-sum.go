func combinationSum(candidates []int, target int) [][]int {
    var res [][]int
    var path []int
    sort.Ints(candidates)
    backtrack(candidates, target, 0, path, &res)
    return res
}

func backtrack(candidates []int, target int, start int, path []int, res *[][]int) {
    if target == 0 {
        tmp := make([]int, len(path))
        copy(tmp, path)
        *res = append(*res, tmp)
        return
    }
    for i := start; i < len(candidates); i++ {
        if candidates[i] > target {
            break
        }
        path = append(path, candidates[i])
        backtrack(candidates, target-candidates[i], i, path, res)
        path = path[:len(path)-1]
    }
}