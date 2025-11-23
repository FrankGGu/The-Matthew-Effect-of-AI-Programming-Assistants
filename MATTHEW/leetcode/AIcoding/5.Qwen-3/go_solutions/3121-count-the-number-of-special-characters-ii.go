package main

func numberOfSpecialChars(word string) int {
    first := make(map[rune]int)
    last := make(map[rune]int)

    for i, c := range word {
        if _, ok := first[c]; !ok {
            first[c] = i
        }
        last[c] = i
    }

    count := 0

    for c := range first {
        if c >= 'a' && c <= 'z' {
            upper := rune(c - 'a' + 'A')
            if _, ok := first[upper]; ok {
                if first[upper] < last[c] {
                    count++
                }
            }
        }
    }

    return count
}