func minimizedStringLength(s string) int {
    seen := make(map[rune]bool)
    for _, c := range s {
        seen[c] = true
    }
    return len(seen)
}