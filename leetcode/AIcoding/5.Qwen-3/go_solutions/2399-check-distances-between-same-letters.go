package main

func checkDistances(s string, distance []int) bool {
    last := make(map[rune]int)
    for i, char := range s {
        if prev, ok := last[char]; ok {
            if i-prev-1 != distance[char-'a'] {
                return false
            }
        } else {
            last[char] = i
        }
    }
    return true
}