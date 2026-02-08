func smallestSubstring(s string) string {
    lastIndex := make(map[byte]int)
    minLength := len(s) + 1
    result := ""

    for i := 0; i < len(s); i++ {
        if idx, found := lastIndex[s[i]]; found {
            length := i - idx + 1
            if length < minLength {
                minLength = length
                result = s[idx : i+1]
            }
        }
        lastIndex[s[i]] = i
    }

    return result
}