func countVowelSubstrings(word string) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    count := 0
    n := len(word)

    for i := 0; i < n; i++ {
        seen := make(map[byte]bool)
        for j := i; j < n; j++ {
            if !vowels[word[j]] {
                break
            }
            seen[word[j]] = true
            if len(seen) == 5 {
                count++
            }
        }
    }

    return count
}