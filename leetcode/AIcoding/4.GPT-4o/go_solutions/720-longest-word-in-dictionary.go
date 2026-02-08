import "sort"

func longestWord(words []string) string {
    sort.Strings(words)
    longest := ""
    wordSet := map[string]bool{}
    wordSet[""] = true

    for _, word := range words {
        if len(word) == 1 || wordSet[word[:len(word)-1]] {
            wordSet[word] = true
            if len(word) > len(longest) {
                longest = word
            }
        }
    }

    return longest
}