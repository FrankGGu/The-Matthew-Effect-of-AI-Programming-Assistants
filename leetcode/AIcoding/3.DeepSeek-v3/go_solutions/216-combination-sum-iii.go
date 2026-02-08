func combinationSum3(k int, n int) [][]int {
    var res [][]int
    var backtrack func(start, sum int, path []int)
    backtrack = func(start, sum int, path []int) {
        if len(path) == k && sum == n {
            tmp := make([]int, k)
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        if len(path) > k || sum > n {
            return
        }
        for i := start; i <= 9; i++ {
            path = append(path, i)
            backtrack(i+1, sum+i, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(1, 0, []int{})
    return res
}