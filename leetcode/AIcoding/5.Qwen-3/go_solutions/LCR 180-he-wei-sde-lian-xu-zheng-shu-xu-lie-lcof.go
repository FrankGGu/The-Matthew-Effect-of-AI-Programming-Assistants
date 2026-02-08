package main

func combine(n int, k int) [][]int {
    result := [][]int{}
    path := []int{}

    var backtrack func(int)
    backtrack = func(start int) {
        if len(path) == k {
            temp := make([]int, k)
            copy(temp, path)
            result = append(result, temp)
            return
        }
        for i := start; i <= n; i++ {
            path = append(path, i)
            backtrack(i + 1)
            path = path[:len(path)-1]
        }
    }

    backtrack(1)
    return result
}