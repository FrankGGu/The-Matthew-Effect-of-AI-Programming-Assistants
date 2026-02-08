package main

func combinationSum(candidates []int, target int) [][]int {
    result := [][]int{}
    path := []int{}
    var backtrack func(start int)
    backtrack = func(start int) {
        if sum(path) == target {
            temp := make([]int, len(path))
            copy(temp, path)
            result = append(result, temp)
            return
        }
        if sum(path) > target {
            return
        }
        for i := start; i < len(candidates); i++ {
            path = append(path, candidates[i])
            backtrack(i)
            path = path[:len(path)-1]
        }
    }
    backtrack(0)
    return result
}

func sum(nums []int) int {
    s := 0
    for _, num := range nums {
        s += num
    }
    return s
}