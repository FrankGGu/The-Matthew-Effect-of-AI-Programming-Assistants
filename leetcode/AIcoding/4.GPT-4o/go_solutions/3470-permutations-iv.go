func permuteUnique(nums []int) [][]int {
    sort.Ints(nums)
    var result [][]int
    var path []int
    used := make([]bool, len(nums))
    backtrack(nums, &result, path, used)
    return result
}

func backtrack(nums []int, result *[][]int, path []int, used []bool) {
    if len(path) == len(nums) {
        temp := make([]int, len(path))
        copy(temp, path)
        *result = append(*result, temp)
        return
    }
    for i := 0; i < len(nums); i++ {
        if used[i] {
            continue
        }
        if i > 0 && nums[i] == nums[i-1] && !used[i-1] {
            continue
        }
        used[i] = true
        path = append(path, nums[i])
        backtrack(nums, result, path, used)
        used[i] = false
        path = path[:len(path)-1]
    }
}