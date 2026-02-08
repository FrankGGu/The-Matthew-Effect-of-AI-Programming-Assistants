package main

func permuteUnique(nums []int) [][]int {
    var res [][]int
    var path []int
    used := make([]bool, len(nums))
    sort.Ints(nums)
    backtrack(nums, used, path, &res)
    return res
}

func backtrack(nums []int, used []bool, path []int, res *[][]int) {
    if len(path) == len(nums) {
        *res = append(*res, append([]int{}, path...))
        return
    }
    for i := 0; i < len(nums); i++ {
        if used[i] {
            continue
        }
        if i > 0 && nums[i] == nums[i-1] && used[i-1] {
            continue
        }
        used[i] = true
        path = append(path, nums[i])
        backtrack(nums, used, path, res)
        path = path[:len(path)-1]
        used[i] = false
    }
}