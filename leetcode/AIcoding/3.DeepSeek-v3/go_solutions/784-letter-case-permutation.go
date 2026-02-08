func letterCasePermutation(s string) []string {
    res := []string{}
    backtrack(&res, []byte(s), 0)
    return res
}

func backtrack(res *[]string, s []byte, pos int) {
    if pos == len(s) {
        *res = append(*res, string(s))
        return
    }

    if s[pos] >= '0' && s[pos] <= '9' {
        backtrack(res, s, pos+1)
        return
    }

    s[pos] = toLower(s[pos])
    backtrack(res, s, pos+1)

    s[pos] = toUpper(s[pos])
    backtrack(res, s, pos+1)
}

func toLower(c byte) byte {
    if c >= 'A' && c <= 'Z' {
        return c + 32
    }
    return c
}

func toUpper(c byte) byte {
    if c >= 'a' && c <= 'z' {
        return c - 32
    }
    return c
}