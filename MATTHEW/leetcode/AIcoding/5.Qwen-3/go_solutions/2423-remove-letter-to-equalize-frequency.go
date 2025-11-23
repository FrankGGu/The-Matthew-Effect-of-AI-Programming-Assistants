package main

func equalizeFrequency(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    for c := range count {
        count[c]--
        if count[c] == 0 {
            delete(count, c)
        }
        freq := make(map[int]bool)
        for _, v := range count {
            freq[v] = true
        }
        if len(freq) == 1 {
            return true
        }
        if count[c] > 0 {
            count[c]++
        } else {
            count[c] = 1
        }
    }
    return false
}