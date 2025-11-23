func kMirror(k int, n int) int64 {
    sum := int64(0)
    count := 0
    length := 1
    for count < n {
        for halfLen := (length + 1) / 2; halfLen <= length; halfLen++ {
            for num := int64(math.Pow10(halfLen - 1)); num < int64(math.Pow10(halfLen)); num++ {
                str := strconv.FormatInt(num, 10)
                var mirrorStr strings.Builder
                mirrorStr.WriteString(str)
                for i := len(str) - 1 - (length % 2); i >= 0; i-- {
                    mirrorStr.WriteByte(str[i])
                }
                mirrorNum, _ := strconv.ParseInt(mirrorStr.String(), 10, 64)
                kStr := strconv.FormatInt(mirrorNum, k)
                if isPalindrome(kStr) {
                    sum += mirrorNum
                    count++
                    if count == n {
                        return sum
                    }
                }
            }
        }
        length++
    }
    return sum
}

func isPalindrome(s string) bool {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}