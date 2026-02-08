func makeLargestSpecial(s string) string {
    count, i := 0, 0
    res := make([]string, 0)
    for j, ch := range s {
        if ch == '1' {
            count++
        } else {
            count--
        }
        if count == 0 {
            res = append(res, "1"+makeLargestSpecial(s[i+1:j])+"0")
            i = j + 1
        }
    }
    sort.Slice(res, func(i, j int) bool { return res[i] > res[j] })
    return strings.Join(res, "")
}