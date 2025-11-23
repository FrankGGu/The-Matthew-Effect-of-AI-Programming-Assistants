func vowelStrings(words []string, left int, right int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    count := 0
    for i := left; i <= right; i++ {
        word := words[i]
        if vowels[word[0]] && vowels[word[len(word)-1]] {
            count++
        }
    }
    return count
}