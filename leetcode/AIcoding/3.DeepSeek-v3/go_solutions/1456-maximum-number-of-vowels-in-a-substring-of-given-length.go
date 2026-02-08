func maxVowels(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    maxCount := 0
    currentCount := 0

    for i := 0; i < k; i++ {
        if vowels[s[i]] {
            currentCount++
        }
    }
    maxCount = currentCount

    for i := k; i < len(s); i++ {
        if vowels[s[i-k]] {
            currentCount--
        }
        if vowels[s[i]] {
            currentCount++
        }
        if currentCount > maxCount {
            maxCount = currentCount
        }
    }

    return maxCount
}