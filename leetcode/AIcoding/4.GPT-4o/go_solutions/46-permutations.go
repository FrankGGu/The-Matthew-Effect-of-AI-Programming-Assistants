func permute(nums []int) [][]int {
    var result [][]int
    var backtrack func(path []int, used []bool)
    backtrack = func(path []int, used []bool) {
        if len(path) == len(nums) {
            temp := make([]int, len(path))
            copy(temp, path)
            result = append(result, temp)
            return
        }
        for i := 0; i < len(nums); i++ {
            if used[i] {
                continue
            }
            used[i] = true
            path = append(path, nums[i])
            backtrack(path, used)
            used[i] = false
            path = path[:len(path)-1]
        }
    }
    backtrack([]int{}, make([]bool, len(nums)))
    return result
}