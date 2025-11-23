func minimumLength(s string) int {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] == s[right] {
            char := s[left]
            for left <= right && s[left] == char {
                left++
            }
            for left <= right && s[right] == char {
                right--
            }
        } else {
            break
        }
    }
    return right - left + 1
}