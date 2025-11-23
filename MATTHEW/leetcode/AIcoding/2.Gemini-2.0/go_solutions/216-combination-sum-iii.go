func combinationSum3(k int, n int) [][]int {
    result := [][]int{}
    var backtrack func(combination []int, start int, remaining int)
    backtrack = func(combination []int, start int, remaining int) {
        if len(combination) == k && remaining == 0 {
            temp := make([]int, len(combination))
            copy(temp, combination)
            result = append(result, temp)
            return
        }

        if len(combination) == k || remaining < 0 {
            return
        }

        for i := start; i <= 9; i++ {
            combination = append(combination, i)
            backtrack(combination, i+1, remaining-i)
            combination = combination[:len(combination)-1]
        }
    }

    backtrack([]int{}, 1, n)
    return result
}