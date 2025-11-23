func partition(s string) [][]string {
    var result [][]string
    var path []string
    var backtrack func(start int)

    backtrack = func(start int) {
        if start >= len(s) {
            temp := make([]string, len(path))
            copy(temp, path)
            result = append(result, temp)
            return
        }
        for end := start + 1; end <= len(s); end++ {
            substring := s[start:end]
            if isPalindrome(substring) {
                path = append(path, substring)
                backtrack(end)
                path = path[:len(path)-1]
            }
        }
    }

    backtrack(0)
    return result
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