func longestPrefix(s string) string {
    n := len(s)
    lps := make([]int, n)
    length := 0
    i := 1
    for i < n {
        if s[i] == s[length] {
            length++
            lps[i] = length
            i++
        } else {
            if length != 0 {
                length = lps[length-1]
            } else {
                lps[i] = 0
                i++
            }
        }
    }
    return s[:lps[n-1]]
}