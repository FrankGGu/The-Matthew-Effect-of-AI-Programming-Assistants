func combinationSum(candidates []int, target int) [][]int {
    var res [][]int
    var path []int
    var dfs func(int, int)
    dfs = func(start, sum int) {
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
            path = append(path, candidates[i])
            dfs(i, sum + candidates[i])
            path = path[:len(path)-1]
        }
    }
    dfs(0, 0)
    return res
}