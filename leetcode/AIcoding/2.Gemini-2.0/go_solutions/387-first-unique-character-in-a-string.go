func firstUniqChar(s string) int {
    freq := make(map[rune]int)
    for _, r := range s {
        freq[r]++
    }
    for i, r := range s {
        if freq[r] == 1 {
            return i
        }
    }
    return -1
}