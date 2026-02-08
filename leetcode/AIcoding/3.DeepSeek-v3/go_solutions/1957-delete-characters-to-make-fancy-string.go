func makeFancyString(s string) string {
    if len(s) < 3 {
        return s
    }
    res := []byte{s[0], s[1]}
    for i := 2; i < len(s); i++ {
        if s[i] == res[len(res)-1] && s[i] == res[len(res)-2] {
            continue
        }
        res = append(res, s[i])
    }
    return string(res)
}