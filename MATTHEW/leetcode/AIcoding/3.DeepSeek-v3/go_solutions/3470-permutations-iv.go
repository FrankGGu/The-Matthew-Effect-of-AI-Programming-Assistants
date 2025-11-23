func permuteUnique(nums []int) [][]int {
    var res [][]int
    sort.Ints(nums)
    n := len(nums)
    used := make([]bool, n)
    var backtrack func([]int)
    backtrack = func(path []int) {
        if len(path) == n {
            tmp := make([]int, n)
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        for i := 0; i < n; i++ {
            if used[i] || (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
                continue
            }
            used[i] = true
            path = append(path, nums[i])
            backtrack(path)
            path = path[:len(path)-1]
            used[i] = false
        }
    }
    backtrack([]int{})
    return res
}