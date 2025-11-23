func findSubsequences(nums []int) [][]int {
    var res [][]int
    var path []int
    var backtrack func(int)
    backtrack = func(start int) {
        if len(path) >= 2 {
            tmp := make([]int, len(path))
            copy(tmp, path)
            res = append(res, tmp)
        }
        used := make(map[int]bool)
        for i := start; i < len(nums); i++ {
            if used[nums[i]] {
                continue
            }
            if len(path) == 0 || nums[i] >= path[len(path)-1] {
                used[nums[i]] = true
                path = append(path, nums[i])
                backtrack(i + 1)
                path = path[:len(path)-1]
            }
        }
    }
    backtrack(0)
    return res
}