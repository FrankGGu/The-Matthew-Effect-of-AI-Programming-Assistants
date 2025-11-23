func findKthBit(n int, k int) byte {
    s := "0"
    for i := 2; i <= n; i++ {
        inverted := invert(s)
        reversed := reverse(inverted)
        s = s + "1" + reversed
    }
    return s[k-1]
}

func invert(s string) string {
    res := make([]byte, len(s))
    for i := 0; i < len(s); i++ {
        if s[i] == '0' {
            res[i] = '1'
        } else {
            res[i] = '0'
        }
    }
    return string(res)
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}