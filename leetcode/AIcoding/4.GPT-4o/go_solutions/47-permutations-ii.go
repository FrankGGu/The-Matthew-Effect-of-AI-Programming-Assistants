import "sort"

func permuteUnique(nums []int) [][]int {
    var res [][]int
    sort.Ints(nums)
    backtrack(&res, nums, []int{}, make([]bool, len(nums)))
    return res
}

func backtrack(res *[][]int, nums, path []int, used []bool) {
    if len(path) == len(nums) {
        temp := make([]int, len(path))
        copy(temp, path)
        *res = append(*res, temp)
        return
    }
    for i := 0; i < len(nums); i++ {
        if used[i] || (i > 0 && nums[i] == nums[i-1] && !used[i-1]) {
            continue
        }
        used[i] = true
        path = append(path, nums[i])
        backtrack(res, nums, path, used)
        used[i] = false
        path = path[:len(path)-1]
    }
}