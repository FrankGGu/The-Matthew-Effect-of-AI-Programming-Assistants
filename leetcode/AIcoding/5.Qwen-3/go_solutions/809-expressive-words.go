package main

func expressiveWords(s string, words []string) int {
    count := 0
    for _, word := range words {
        if isExpressive(s, word) {
            count++
        }
    }
    return count
}

func isExpressive(s, word string) bool {
    i, j := 0, 0
    for i < len(s) && j < len(word) {
        if s[i] != word[j] {
            return false
        }
        c := s[i]
        cntS, cntW := 0, 0
        for i < len(s) && s[i] == c {
            i++
            cntS++
        }
        for j < len(word) && word[j] == c {
            j++
            cntW++
        }
        if cntS < cntW || (cntS > cntW && cntS < 3) {
            return false
        }
    }
    return i == len(s) && j == len(word)
}