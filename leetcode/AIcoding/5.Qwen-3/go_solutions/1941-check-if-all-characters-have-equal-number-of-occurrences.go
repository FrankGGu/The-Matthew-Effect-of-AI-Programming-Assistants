package main

func areOccurrencesEqual(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    var first int
    for _, v := range count {
        first = v
        break
    }
    for _, v := range count {
        if v != first {
            return false
        }
    }
    return true
}