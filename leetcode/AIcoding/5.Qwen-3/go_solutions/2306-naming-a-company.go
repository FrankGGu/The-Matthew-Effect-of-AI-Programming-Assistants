package main

func distinctNames(words1 []string, words2 []string) int {
    set1 := make(map[string]bool)
    set2 := make(map[string]bool)

    for _, word := range words1 {
        set1[word] = true
    }

    for _, word := range words2 {
        set2[word] = true
    }

    result := 0

    for a := range set1 {
        for b := range set2 {
            if a != b {
                result++
            }
        }
    }

    return result
}