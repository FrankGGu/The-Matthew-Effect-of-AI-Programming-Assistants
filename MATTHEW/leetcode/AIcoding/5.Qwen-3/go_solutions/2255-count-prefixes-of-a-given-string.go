package main

func countPrefixes(words []string, s string) int {
    count := 0
    for _, word := range words {
        if len(word) > len(s) {
            continue
        }
        match := true
        for i := 0; i < len(word); i++ {
            if word[i] != s[i] {
                match = false
                break
            }
        }
        if match {
            count++
        }
    }
    return count
}