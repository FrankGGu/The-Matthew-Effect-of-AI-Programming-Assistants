func combine(n int, k int) [][]int {
    var res [][]int
    var backtrack func(start int, path []int)

    backtrack = func(start int, path []int) {
        if len(path) == k {
            tmp := make([]int, k)
            copy(tmp, path)
            res = append(res, tmp)
            return
        }

        for i := start; i <= n; i++ {
            path = append(path, i)
            backtrack(i+1, path)
            path = path[:len(path)-1]
        }
    }

    backtrack(1, []int{})
    return res
}