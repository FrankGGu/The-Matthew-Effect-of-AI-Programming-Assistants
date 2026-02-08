func permute(nums []int) [][]int {
    var res [][]int
    var backtrack func([]int, []bool)
    backtrack = func(path []int, used []bool) {
        if len(path) == len(nums) {
            tmp := make([]int, len(path))
            copy(tmp, path)
            res = append(res, tmp)
            return
        }
        for i := 0; i < len(nums); i++ {
            if !used[i] {
                used[i] = true
                path = append(path, nums[i])
                backtrack(path, used)
                path = path[:len(path)-1]
                used[i] = false
            }
        }
    }
    backtrack([]int{}, make([]bool, len(nums)))
    return res
}