func checkIfPangram(sentence string) bool {
    seen := make(map[rune]bool)
    for _, c := range sentence {
        seen[c] = true
    }
    return len(seen) == 26
}