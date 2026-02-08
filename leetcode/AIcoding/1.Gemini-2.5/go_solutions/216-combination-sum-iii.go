func combinationSum3(k int, n int) [][]int {
    var result [][]int
    var currentCombination []int

    var backtrack func(remainingK, remainingN, startNum int)
    backtrack = func(remainingK, remainingN, startNum int) {
        if remainingK == 0 && remainingN == 0 {
            temp := make([]int, len(currentCombination))
            copy(temp, currentCombination)
            result = append(result, temp)
            return
        }

        if remainingK < 0 || remainingN < 0 {
            return
        }

        for i := startNum; i <= 9; i++ {
            currentCombination = append(currentCombination, i)
            backtrack(remainingK-1, remainingN-i, i+1)
            currentCombination = currentCombination[:len(currentCombination)-1]
        }
    }

    backtrack(k, n, 1)
    return result
}