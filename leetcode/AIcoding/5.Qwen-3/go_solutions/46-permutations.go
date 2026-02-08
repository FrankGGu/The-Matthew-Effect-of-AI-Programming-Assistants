package main

func permute(nums []int) [][]int {
    result := [][]int{}
    used := make([]bool, len(nums))
    backtrack(nums, used, []int{}, &result)
    return result
}

func backtrack(nums []int, used []bool, path []int, result *[][]int) {
    if len(path) == len(nums) {
        *result = append(*result, append([]int{}, path...))
        return
    }
    for i := 0; i < len(nums); i++ {
        if used[i] {
            continue
        }
        used[i] = true
        path = append(path, nums[i])
        backtrack(nums, used, path, result)
        path = path[:len(path)-1]
        used[i] = false
    }
}