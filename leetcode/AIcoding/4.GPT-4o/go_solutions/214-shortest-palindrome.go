func shortestPalindrome(s string) string {
    n := len(s)
    if n == 0 {
        return ""
    }

    rev := reverse(s)
    newStr := s + "#" + rev
    lps := computeLPS(newStr)

    return rev[:n-lps[len(lps)-1]] + s
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func computeLPS(s string) []int {
    lps := make([]int, len(s))
    length := 0
    i := 1
    for i < len(s) {
        if s[i] == s[length] {
            length++
            lps[i] = length
            i++
        } else {
            if length != 0 {
                length = lps[length-1]
            } else {
                lps[i] = 0
                i++
            }
        }
    }
    return lps
}