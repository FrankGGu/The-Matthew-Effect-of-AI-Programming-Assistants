func findLongestWord(s string, dictionary []string) string {
    var res string
    for _, word := range dictionary {
        if isSubsequence(word, s) {
            if len(word) > len(res) || (len(word) == len(res) && word < res) {
                res = word
            }
        }
    }
    return res
}

func isSubsequence(word, s string) bool {
    i, j := 0, 0
    for i < len(word) && j < len(s) {
        if word[i] == s[j] {
            i++
        }
        j++
    }
    return i == len(word)
}