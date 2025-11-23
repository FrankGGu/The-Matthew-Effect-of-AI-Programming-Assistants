func digitSum(s string, k int) string {
    for len(s) > k {
        var newS strings.Builder
        for i := 0; i < len(s); i += k {
            sum := 0
            for j := i; j < i+k && j < len(s); j++ {
                sum += int(s[j] - '0')
            }
            newS.WriteString(strconv.Itoa(sum))
        }
        s = newS.String()
    }
    return s
}