import "sort"

func permuteUnique(nums []int) [][]int {
    result := [][]int{}
    sort.Ints(nums)
    backtrack(nums, []int{}, make([]bool, len(nums)), &result)
    return result
}

func backtrack(nums []int, path []int, used []bool, result *[][]int) {
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
        backtrack(nums, path, used, result)
        used[i] = false
        path = path[:len(path)-1]
    }
}