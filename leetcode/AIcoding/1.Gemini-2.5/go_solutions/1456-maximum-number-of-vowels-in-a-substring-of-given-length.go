func maxVowels(s string, k int) int {
    isVowel := func(c byte) bool {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
    }

    currentVowels := 0
    for i := 0; i < k; i++ {
        if isVowel(s[i]) {
            currentVowels++
        }
    }

    maxVowelsCount := currentVowels

    for i := k; i < len(s); i++ {
        if isVowel(s[i-k]) {
            currentVowels--
        }
        if isVowel(s[i]) {
            currentVowels++
        }
        if currentVowels > maxVowelsCount {
            maxVowelsCount = currentVowels
        }
    }

    return maxVowelsCount
}