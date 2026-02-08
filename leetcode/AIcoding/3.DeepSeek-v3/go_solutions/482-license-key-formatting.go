func licenseKeyFormatting(s string, k int) string {
    var res []byte
    count := 0
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] != '-' {
            res = append(res, toUpper(s[i]))
            count++
            if count % k == 0 {
                res = append(res, '-')
            }
        }
    }
    if len(res) > 0 && res[len(res)-1] == '-' {
        res = res[:len(res)-1]
    }
    reverse(res)
    return string(res)
}

func toUpper(c byte) byte {
    if c >= 'a' && c <= 'z' {
        return c - 'a' + 'A'
    }
    return c
}

func reverse(s []byte) {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        s[i], s[j] = s[j], s[i]
    }
}