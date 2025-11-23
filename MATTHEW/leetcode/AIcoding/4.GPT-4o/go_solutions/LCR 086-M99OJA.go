func partition(s string) [][]string {
    var result [][]string
    var current []string
    backtrack(s, 0, current, &result)
    return result
}

func backtrack(s string, start int, current []string, result *[][]string) {
    if start >= len(s) {
        temp := make([]string, len(current))
        copy(temp, current)
        *result = append(*result, temp)
        return
    }
    for end := start + 1; end <= len(s); end++ {
        if isPalindrome(s[start:end]) {
            current = append(current, s[start:end])
            backtrack(s, end, current, result)
            current = current[:len(current)-1]
        }
    }
}

func isPalindrome(s string) bool {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}