package main

func subsetsWithDup(nums []int) [][]int {
    var result [][]int
    var backtrack func(int, []int)
    sort.Ints(nums)
    backtrack = func(start int, path []int) {
        temp := make([]int, len(path))
        copy(temp, path)
        result = append(result, temp)
        for i := start; i < len(nums); i++ {
            if i > start && nums[i] == nums[i-1] {
                continue
            }
            path = append(path, nums[i])
            backtrack(i+1, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(0, []int{})
    return result
}