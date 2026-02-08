func shiftingLetters(s string, shifts []int) string {
    n := len(s)
    totalShift := 0
    res := make([]byte, n)
    for i := n - 1; i >= 0; i-- {
        totalShift += shifts[i]
        res[i] = 'a' + (byte(s[i]-'a')+byte(totalShift%26)+26)%26
    }
    return string(res)
}