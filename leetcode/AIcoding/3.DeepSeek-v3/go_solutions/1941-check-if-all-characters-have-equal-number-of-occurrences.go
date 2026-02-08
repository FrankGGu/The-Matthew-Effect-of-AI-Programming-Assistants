func areOccurrencesEqual(s string) bool {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }
    count := -1
    for _, v := range freq {
        if count == -1 {
            count = v
        } else if v != count {
            return false
        }
    }
    return true
}