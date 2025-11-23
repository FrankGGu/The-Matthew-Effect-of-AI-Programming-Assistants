func findSubsequences(nums []int) [][]int {
    var results [][]int
    var path []int

    var backtrack func(start int)
    backtrack = func(start int) {
        // If current path has at least two elements, it's a valid non-decreasing subsequence.
        if len(path) >= 2 {