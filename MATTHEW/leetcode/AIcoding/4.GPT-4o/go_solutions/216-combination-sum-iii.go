func combinationSum3(k int, n int) [][]int {
    res := [][]int{}
    var backtrack func(start int, target int, path []int)
    backtrack = func(start int, target int, path []int) {
        if len(path) == k && target == 0 {
            tmp := make([]int, k)
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        for i := start; i <= 9; i++ {
            if target < i {
                break
            }
            path = append(path, i)
            backtrack(i+1, target-i, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(1, n, []int{})
    return res
}