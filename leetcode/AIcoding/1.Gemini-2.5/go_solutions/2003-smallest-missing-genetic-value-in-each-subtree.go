func smallestMissingValueSubtree(parents []int, nums []int) []int {
    n := len(parents)
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parents[i]
        children[p] = append(children[p], i)
    }

    res := make([]int, n)
    for i := range res {
        res[i] = 1
    }

    var dfs func(int) map[int]bool
    dfs = func(u int) map[int]bool {
        vals := make(map[int]bool)
        vals[nums[u]] = true
        for _, v := range children[u] {
            childVals := dfs(v)
            if len(childVals) > len(vals) {
                vals, childVals = childVals, vals
            }
            for val := range childVals {
                vals[val] = true
            }
            if res[v] > res[u] {
                res[u] = res[v]
            }
        }
        for vals[res[u]] {
            res[u]++
        }
        return vals
    }
    dfs(0)
    return res
}