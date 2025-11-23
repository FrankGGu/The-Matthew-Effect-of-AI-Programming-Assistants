func combine(n int, k int) [][]int {
    result := [][]int{}
    var backtrack func(start int, path []int)
    backtrack = func(start int, path []int) {
        if len(path) == k {
            combination := make([]int, k)
            copy(combination, path)
            result = append(result, combination)
            return
        }
        for i := start; i <= n; i++ {
            path = append(path, i)
            backtrack(i+1, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(1, []int{})
    return result
}