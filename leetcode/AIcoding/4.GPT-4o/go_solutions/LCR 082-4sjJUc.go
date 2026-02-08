func combinationSum2(candidates []int, target int) [][]int {
    var res [][]int
    var path []int
    sort.Ints(candidates)
    backtrack(candidates, target, 0, path, &res)
    return res
}

func backtrack(candidates []int, target, start int, path []int, res *[][]int) {
    if target == 0 {
        temp := make([]int, len(path))
        copy(temp, path)
        *res = append(*res, temp)
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
        backtrack(candidates, target-candidates[i], i+1, path, res)
        path = path[:len(path)-1]
    }
}