func shiftingLetters(s string, shifts []int) string {
    n := len(s)
    result := make([]byte, n)
    totalShift := 0

    for i := n - 1; i >= 0; i-- {
        totalShift = (totalShift + shifts[i]) % 26
        result[i] = byte((int(s[i]-'a') + totalShift) % 26 + 'a')
    }

    return string(result)
}