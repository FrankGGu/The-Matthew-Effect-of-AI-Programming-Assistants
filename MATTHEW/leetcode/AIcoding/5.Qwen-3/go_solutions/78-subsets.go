package main

func subsets(nums []int) [][]int {
    result := [][]int{}
    backtrack(nums, 0, []int{}, &result)
    return result
}

func backtrack(nums []int, start int, path []int, result *[][]int) {
    *result = append(*result, append([]int{}, path...))
    for i := start; i < len(nums); i++ {
        path = append(path, nums[i])
        backtrack(nums, i+1, path, result)
        path = path[:len(path)-1]
    }
}