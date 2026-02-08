func getHappyString(n int, k int) string {
    var res strings.Builder
    count := 0
    var backtrack func(string)

    backtrack = func(s string) {
        if count >= k {
            return
        }
        if len(s) == n {
            count++
            if count == k {
                res.WriteString(s)
            }
            return
        }
        for _, c := range []byte{'a', 'b', 'c'} {
            if len(s) == 0 || s[len(s)-1] != c {
                backtrack(s + string(c))
            }
        }
    }

    backtrack("")
    return res.String()
}