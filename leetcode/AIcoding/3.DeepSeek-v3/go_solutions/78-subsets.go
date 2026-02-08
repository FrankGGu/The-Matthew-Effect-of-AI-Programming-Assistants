func subsets(nums []int) [][]int {
    var res [][]int
    var backtrack func(start int, path []int)
    backtrack = func(start int, path []int) {
        tmp := make([]int, len(path))
        copy(tmp, path)
        res = append(res, tmp)
        for i := start; i < len(nums); i++ {
            path = append(path, nums[i])
            backtrack(i+1, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(0, []int{})
    return res
}