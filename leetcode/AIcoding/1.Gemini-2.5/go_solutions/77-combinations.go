func combine(n int, k int) [][]int {
    var result [][]int
    var currentCombination []int

    var backtrack func(start int)
    backtrack = func(start int) {
        // Base case: if the current combination has k elements, add it to the result
        if len(currentCombination