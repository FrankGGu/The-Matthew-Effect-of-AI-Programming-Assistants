func monotoneIncreasingDigits(n int) int {
    s := []byte(strconv.Itoa(n))
    i := 1
    for i < len(s) && s[i-1] <= s[i] {
        i++
    }
    if i < len(s) {
        for i > 0 && s[i-1] > s[i] {
            s[i-1]--
            i--
        }
        for j := i + 1; j < len(s); j++ {
            s[j] = '9'
        }
    }
    res, _ := strconv.Atoi(string(s))
    return res
}