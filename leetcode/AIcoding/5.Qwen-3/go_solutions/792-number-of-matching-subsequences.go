package main

func numMatchingSubseq(s string, words []string) int {
    count := 0
    m := make(map[rune][]string)
    for _, word := range words {
        m[rune(word[0])] = append(m[rune(word[0])], word)
    }
    for i := 0; i < len(s); i++ {
        r := rune(s[i])
        if list, ok := m[r]; ok {
            for _, word := range list {
                if len(word) == 1 {
                    count++
                } else {
                    m[rune(word[1])] = append(m[rune(word[1])], word[1:])
                }
            }
            delete(m, r)
        }
    }
    return count
}