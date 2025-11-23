func getPermutation(n int) []int {
    sequence := make([]int, 2*n-1)
    used := make([]bool, n+1) // used[i] is true if number i has been placed

    var backtrack func(idx int) bool
    backtrack = func(idx int) bool {
        if