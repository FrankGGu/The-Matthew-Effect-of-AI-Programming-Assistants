func smallestSubstring(s string) string {
    n := len(s)
    if n == 0 {
        return ""
    }

    left, right := 0, 0
    minLength := n + 1
    result := ""

    charCount := make(map[byte]int)

    for right < n {
        charCount[s[right]]++

        for len(charCount) == 2 {
            if right-left+1 < minLength {
                minLength = right - left + 1
                result = s[left : right+1]
            }
            charCount[s[left]]--
            if charCount[s[left]] == 0 {
                delete(charCount, s[left])
            }
            left++
        }
        right++
    }

    return result
}