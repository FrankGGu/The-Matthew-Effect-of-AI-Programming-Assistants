func partition(s string) [][]string {
    var result [][]string
    var current []string
    backtrack(&result, current, s, 0)
    return result
}

func backtrack(result *[][]string, current []string, s string, start int) {
    if start == len(s) {
        temp := make([]string, len(current))
        copy(temp, current)
        *result = append(*result, temp)
        return
    }
    for i := start; i < len(s); i++ {
        if isPalindrome(s, start, i) {
            current = append(current, s[start:i+1])
            backtrack(result, current, s, i+1)
            current = current[:len(current)-1]
        }
    }
}

func isPalindrome(s string, left, right int) bool {
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}