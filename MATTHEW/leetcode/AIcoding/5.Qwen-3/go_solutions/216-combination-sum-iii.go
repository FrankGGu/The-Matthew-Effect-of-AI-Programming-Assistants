package main

func combinationSum3(k int, n int) [][]int {
    result := [][]int{}
    path := []int{}

    var backtrack func(start int)
    backtrack = func(start int) {
        if len(path) == k {
            if sum(path) == n {
                temp := make([]int, k)
                copy(temp, path)
                result = append(result, temp)
            }
            return
        }

        for i := start; i <= 9; i++ {
            path = append(path, i)
            backtrack(i + 1)
            path = path[:len(path)-1]
        }
    }

    backtrack(1)
    return result
}

func sum(nums []int) int {
    s := 0
    for _, num := range nums {
        s += num
    }
    return s
}