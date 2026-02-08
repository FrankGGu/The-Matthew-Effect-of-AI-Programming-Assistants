package main

func mostWordsFound(sentences []string) int {
    max := 0
    for _, s := range sentences {
        words := 0
        for i := 0; i < len(s); i++ {
            if s[i] == ' ' {
                words++
            }
        }
        if words > max {
            max = words
        }
    }
    return max + 1
}