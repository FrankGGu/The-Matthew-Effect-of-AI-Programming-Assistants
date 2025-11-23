func halvesAreAlike(s string) bool {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true, 'A': true, 'E': true, 'I': true, 'O': true, 'U': true}
    half := len(s) / 2
    aCount, bCount := 0, 0
    for i := 0; i < half; i++ {
        if vowels[s[i]] {
            aCount++
        }
    }
    for i := half; i < len(s); i++ {
        if vowels[s[i]] {
            bCount++
        }
    }
    return aCount == bCount
}