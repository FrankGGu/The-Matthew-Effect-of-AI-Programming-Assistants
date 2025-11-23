func findAllStableBinaryArrays(n int) [][]int {
    result := [][]int{}
    var backtrack func(path []int, idx int)
    backtrack = func(path []int, idx int) {
        if len(path) == n {
            result = append(result, append([]int{}, path...))
            return
        }
        for i := 0; i <= 1; i++ {
            if isStable(path, i) {
                path = append(path, i)
                backtrack(path, idx+1)
                path = path[:len(path)-1]
            }
        }
    }
    backtrack([]int{}, 0)
    return result
}

func isStable(path []int, next int) bool {
    if len(path) < 2 {
        return true
    }
    if (path[len(path)-1] == 1 && next == 1) || (path[len(path)-2] == 1 && path[len(path)-1] == 1) {
        return false
    }
    return true
}