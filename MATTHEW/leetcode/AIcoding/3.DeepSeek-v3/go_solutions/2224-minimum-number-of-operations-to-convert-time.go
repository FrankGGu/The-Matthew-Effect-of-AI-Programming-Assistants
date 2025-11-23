func convertTime(current string, correct string) int {
    parseTime := func(s string) int {
        hh := int(s[0]-'0')*10 + int(s[1]-'0')
        mm := int(s[3]-'0')*10 + int(s[4]-'0')
        return hh*60 + mm
    }
    currentTime := parseTime(current)
    correctTime := parseTime(correct)
    diff := correctTime - currentTime
    if diff < 0 {
        diff += 24 * 60
    }
    operations := 0
    for _, step := range []int{60, 15, 5, 1} {
        operations += diff / step
        diff %= step
    }
    return operations
}