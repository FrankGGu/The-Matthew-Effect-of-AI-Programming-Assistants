func freqAlphabets(s string) string {
    var res strings.Builder
    i := 0
    n := len(s)
    for i < n {
        if i+2 < n && s[i+2] == '#' {
            num, _ := strconv.Atoi(s[i:i+2])
            res.WriteByte('a' + byte(num) - 1)
            i += 3
        } else {
            num, _ := strconv.Atoi(string(s[i]))
            res.WriteByte('a' + byte(num) - 1)
            i++
        }
    }
    return res.String()
}