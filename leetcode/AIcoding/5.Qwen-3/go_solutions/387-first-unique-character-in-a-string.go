package main

func firstUniqChar(s string) int {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }
    for i, ch := range s {
        if freq[ch] == 1 {
            return i
        }
    }
    return -1
}