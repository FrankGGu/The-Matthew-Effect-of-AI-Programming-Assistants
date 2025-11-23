func maxVowels(s string, k int) int {
    vowels := "aeiou"
    maxCount, currentCount := 0, 0

    for i := 0; i < len(s); i++ {
        if strings.ContainsRune(vowels, rune(s[i])) {
            currentCount++
        }
        if i >= k {
            if strings.ContainsRune(vowels, rune(s[i-k])) {
                currentCount--
            }
        }
        if i >= k-1 {
            maxCount = max(maxCount, currentCount)
        }
    }

    return maxCount
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}