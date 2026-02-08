func reformat(s string) string {
    letters := []rune{}
    digits := []rune{}

    for _, c := range s {
        if c >= '0' && c <= '9' {
            digits = append(digits, c)
        } else {
            letters = append(letters, c)
        }
    }

    if abs(len(letters) - len(digits)) > 1 {
        return ""
    }

    var res []rune
    if len(letters) > len(digits) {
        res = interleave(letters, digits)
    } else {
        res = interleave(digits, letters)
    }

    return string(res)
}

func interleave(a, b []rune) []rune {
    res := make([]rune, 0, len(a)+len(b))
    for i := 0; i < len(b); i++ {
        res = append(res, a[i])
        res = append(res, b[i])
    }
    if len(a) > len(b) {
        res = append(res, a[len(a)-1])
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}