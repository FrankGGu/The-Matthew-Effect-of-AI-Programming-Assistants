/**
 * // This is the Master's API interface.
 * // You should not implement it, or speculate about its implementation
 * type Master struct {
 * }
 *
 * func (this *Master) Guess(word string) int {}
 */

func findSecretWord(words []string, master *Master) {
    for i := 0; i < 10; i++ {
        guess := words[rand.Intn(len(words))]
        matches := master.Guess(guess)
        if matches == 6 {
            return
        }
        var newWords []string
        for _, word := range words {
            if countMatches(guess, word) == matches {
                newWords = append(newWords, word)
            }
        }
        words = newWords
    }
}

func countMatches(a, b string) int {
    matches := 0
    for i := 0; i < len(a); i++ {
        if a[i] == b[i] {
            matches++
        }
    }
    return matches
}