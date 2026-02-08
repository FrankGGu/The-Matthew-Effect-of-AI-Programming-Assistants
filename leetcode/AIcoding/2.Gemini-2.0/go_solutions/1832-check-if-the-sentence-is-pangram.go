func checkIfPangram(sentence string) bool {
    seen := make(map[rune]bool)
    for _, char := range sentence {
        if char >= 'a' && char <= 'z' {
            seen[char] = true
        }
    }
    return len(seen) == 26
}