package main

func vowelStrings(words []string, left int, right int) int {
    vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    count := 0
    for i := left; i <= right; i++ {
        word := words[i]
        if len(word) == 0 {
            continue
        }
        first := rune(word[0])
        last := rune(word[len(word)-1])
        if vowels[first] && vowels[last] {
            count++
        }
    }
    return count
}