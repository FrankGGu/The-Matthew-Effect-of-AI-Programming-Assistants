func freqAlphabets(s string) string {
    res := ""
    i := 0
    for i < len(s) {
        if i+2 < len(s) && s[i+2] == '#' {
            num, _ := strconv.Atoi(s[i:i+2])
            res += string(rune('a' + num - 1))
            i += 3
        } else {
            num, _ := strconv.Atoi(s[i:i+1])
            res += string(rune('a' + num - 1))
            i++
        }
    }
    return res
}