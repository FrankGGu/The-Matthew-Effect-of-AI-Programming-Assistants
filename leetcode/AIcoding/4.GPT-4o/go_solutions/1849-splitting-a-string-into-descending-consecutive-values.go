func splitString(s string) bool {
    n := len(s)
    for i := 1; i <= n/2; i++ {
        firstNum, _ := strconv.Atoi(s[:i])
        curNum := firstNum
        count := 1
        j := i
        for j < n {
            curNum--
            nextNum := curNum
            nextNumStr := strconv.Itoa(nextNum)
            if strings.HasPrefix(s[j:], nextNumStr) {
                j += len(nextNumStr)
                count++
            } else {
                break
            }
        }
        if j == n && count > 1 {
            return true
        }
    }
    return false
}