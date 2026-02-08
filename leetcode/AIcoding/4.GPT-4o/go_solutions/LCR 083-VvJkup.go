func permute(nums []int) [][]int {
    var res [][]int
    var backtrack func([]int, []int)
    backtrack = func(path []int, used []int) {
        if len(path) == len(nums) {
            res = append(res, append([]int{}, path...))
            return
        }
        for i := 0; i < len(nums); i++ {
            if used[i] == 1 {
                continue
            }
            used[i] = 1
            backtrack(append(path, nums[i]), used)
            used[i] = 0
        }
    }
    used := make([]int, len(nums))
    backtrack([]int{}, used)
    return res
}