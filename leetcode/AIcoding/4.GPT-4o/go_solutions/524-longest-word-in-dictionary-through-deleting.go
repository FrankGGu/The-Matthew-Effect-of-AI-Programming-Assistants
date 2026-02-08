func findLongestWord(s string, d []string) string {
    result := ""
    for _, word := range d {
        if canForm(s, word) {
            if len(word) > len(result) || (len(word) == len(result) && word < result) {
                result = word
            }
        }
    }
    return result
}

func canForm(s, word string) bool {
    i, j := 0, 0
    for i < len(s) && j < len(word) {
        if s[i] == word[j] {
            j++
        }
        i++
    }
    return j == len(word)
}