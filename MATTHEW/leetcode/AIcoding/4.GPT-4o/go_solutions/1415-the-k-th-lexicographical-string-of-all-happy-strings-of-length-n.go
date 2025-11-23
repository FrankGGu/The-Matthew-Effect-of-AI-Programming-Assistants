func getHappyString(n int, k int) string {
    happyStrings := []string{}
    var backtrack func(curr string)

    backtrack = func(curr string) {
        if len(curr) == n {
            happyStrings = append(happyStrings, curr)
            return
        }
        for _, ch := range "abc" {
            if len(curr) == 0 || curr[len(curr)-1] != byte(ch) {
                backtrack(curr + string(ch))
            }
        }
    }

    backtrack("")

    if k > len(happyStrings) {
        return ""
    }
    return happyStrings[k-1]
}