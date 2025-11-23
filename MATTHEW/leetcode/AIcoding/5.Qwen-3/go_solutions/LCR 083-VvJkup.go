package main

func permute(nums []int) [][]int {
    result := [][]int{}
    used := make([]bool, len(nums))
    var backtrack func([]int)
    backtrack = func(path []int) {
        if len(path) == len(nums) {
            result = append(result, append([]int{}, path...))
            return
        }
        for i := 0; i < len(nums); i++ {
            if used[i] {
                continue
            }
            used[i] = true
            path = append(path, nums[i])
            backtrack(path)
            path = path[:len(path)-1]
            used[i] = false
        }
    }
    backtrack([]int{})
    return result
}