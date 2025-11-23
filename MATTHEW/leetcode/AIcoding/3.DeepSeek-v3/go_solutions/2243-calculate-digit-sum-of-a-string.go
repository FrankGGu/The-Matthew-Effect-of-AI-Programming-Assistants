func digitSum(s string, k int) string {
    for len(s) > k {
        newS := ""
        for i := 0; i < len(s); i += k {
            end := i + k
            if end > len(s) {
                end = len(s)
            }
            group := s[i:end]
            sum := 0
            for _, ch := range group {
                sum += int(ch - '0')
            }
            newS += strconv.Itoa(sum)
        }
        s = newS
    }
    return s
}