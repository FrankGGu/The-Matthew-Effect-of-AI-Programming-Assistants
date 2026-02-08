func commonChars(A []string) []string {
    if len(A) == 0 {
        return []string{}
    }

    charCount := make([]int, 26)
    for _, char := range A[0] {
        charCount[char-'a']++
    }

    for i := 1; i < len(A); i++ {
        currentCount := make([]int, 26)
        for _, char := range A[i] {
            currentCount[char-'a']++
        }
        for j := 0; j < 26; j++ {
            charCount[j] = min(charCount[j], currentCount[j])
        }
    }

    result := []string{}
    for i := 0; i < 26; i++ {
        for j := 0; j < charCount[i]; j++ {
            result = append(result, string(rune('a'+i)))
        }
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}