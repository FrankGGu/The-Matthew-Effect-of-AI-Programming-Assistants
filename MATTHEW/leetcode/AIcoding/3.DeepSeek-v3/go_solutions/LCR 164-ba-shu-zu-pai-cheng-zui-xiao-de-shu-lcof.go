func crackPassword(password []int) string {
    if len(password) == 0 {
        return ""
    }
    strs := make([]string, len(password))
    for i, num := range password {
        strs[i] = strconv.Itoa(num)
    }
    sort.Slice(strs, func(i, j int) bool {
        s1 := strs[i] + strs[j]
        s2 := strs[j] + strs[i]
        return s1 < s2
    })
    var res strings.Builder
    for _, s := range strs {
        res.WriteString(s)
    }
    return res.String()
}