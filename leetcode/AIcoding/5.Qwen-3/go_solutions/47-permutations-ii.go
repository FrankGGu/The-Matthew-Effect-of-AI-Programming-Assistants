package main

func permuteUnique(nums []int) [][]int {
    result := [][]int{}
    used := make([]bool, len(nums))
    sort.Ints(nums)
    var backtrack func(path []int)
    backtrack = func(path []int) {
        if len(path) == len(nums) {
            result = append(result, append([]int{}, path...))
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
            backtrack(path)
            path = path[:len(path)-1]
            used[i] = false
        }
    }
    backtrack([]int{})
    return result
}