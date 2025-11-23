package main

func greatestLetter(s string) string {
    seen := make(map[rune]bool)
    for _, c := range s {
        seen[c] = true
    }
    for i := 25; i >= 0; i-- {
        lower := rune('a' + i)
        upper := rune('A' + i)
        if seen[lower] && seen[upper] {
            return string(upper)
        }
    }
    return ""
}