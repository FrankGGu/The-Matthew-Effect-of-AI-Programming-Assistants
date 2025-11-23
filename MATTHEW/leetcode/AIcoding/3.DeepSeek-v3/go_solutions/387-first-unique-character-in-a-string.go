func firstUniqChar(s string) int {
    freq := make(map[rune]int)
    for _, char := range s {
        freq[char]++
    }
    for i, char := range s {
        if freq[char] == 1 {
            return i
        }
    }
    return -1
}