func generateBinaryStrings(n int) []string {
    result := []string{}
    var backtrack func(string, int)
    backtrack = func(current string, zeros int) {
        if len(current) == n {
            result = append(result, current)
            return
        }
        if zeros < 2 {
            backtrack(current+"0", zeros+1)
        }
        backtrack(current+"1", 0)
    }
    backtrack("", 0)
    return result
}