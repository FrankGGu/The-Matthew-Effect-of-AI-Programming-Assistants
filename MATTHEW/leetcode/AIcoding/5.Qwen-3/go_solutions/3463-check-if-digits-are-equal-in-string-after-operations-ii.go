package main

func areDigitsEqual(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    for _, v := range count {
        if v%2 != 0 {
            return false
        }
    }
    return true
}