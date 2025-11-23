package main

func numStrings(word string, forbidden []string) int {
    set := make(map[string]bool)
    for _, s := range forbidden {
        set[s] = true
    }
    count := 0
    for i := 0; i < len(word); i++ {
        for j := i + 1; j <= len(word); j++ {
            substr := word[i:j]
            if set[substr] {
                count++
                break
            }
        }
    }
    return count
}