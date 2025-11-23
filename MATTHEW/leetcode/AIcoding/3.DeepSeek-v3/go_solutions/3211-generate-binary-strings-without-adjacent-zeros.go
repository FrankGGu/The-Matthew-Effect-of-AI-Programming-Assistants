func generateBinaryStrings(n int) []string {
    var result []string
    var backtrack func(string)

    backtrack = func(s string) {
        if len(s) == n {
            result = append(result, s)
            return
        }
        backtrack(s + "1")
        if len(s) == 0 || s[len(s)-1] != '0' {
            backtrack(s + "0")
        }
    }

    backtrack("")
    return result
}