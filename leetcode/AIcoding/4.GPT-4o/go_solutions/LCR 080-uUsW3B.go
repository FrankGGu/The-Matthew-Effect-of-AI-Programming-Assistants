func combine(n int, k int) [][]int {
    result := [][]int{}
    combination := []int{}

    var backtrack func(start int)
    backtrack = func(start int) {
        if len(combination) == k {
            temp := make([]int, k)
            copy(temp, combination)
            result = append(result, temp)
            return
        }
        for i := start; i <= n; i++ {
            combination = append(combination, i)
            backtrack(i + 1)
            combination = combination[:len(combination)-1]
        }
    }

    backtrack(1)
    return result
}