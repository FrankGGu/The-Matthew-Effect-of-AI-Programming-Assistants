package main

func numberOfSpecialChars(word string) int {
    lastIndices := make([]int, 26)
    for i := range lastIndices {
        lastIndices[i] = -1
    }

    for i := len(word) - 1; i >= 0; i-- {
        c := word[i]
        if 'a' <= c && c <= 'z' {
            idx := int(c - 'a')
            if lastIndices[idx] == -1 {
                lastIndices[idx] = i
            }
        }
    }

    count := 0
    for i := 0; i < 26; i++ {
        if lastIndices[i] != -1 {
            hasUpper := false
            for j := 0; j < len(word); j++ {
                if word[j] == byte('A'+i) {
                    hasUpper = true
                    break
                }
            }
            if hasUpper {
                count++
            }
        }
    }

    return count
}