func isCircularSentence(sentence string) bool {
    words := strings.Fields(sentence)
    n := len(words)
    for i := 0; i < n; i++ {
        if words[i][len(words[i])-1] != words[(i+1)%n][0] {
            return false
        }
    }
    return words[0][0] == words[n-1][len(words[n-1])-1]
}