func isCircularSentence(sentence string) bool {
    words := strings.Fields(sentence)
    n := len(words)
    if n == 0 {
        return true
    }
    first := words[0][0]
    last := words[n-1][len(words[n-1])-1]
    if first != last {
        return false
    }
    for i := 0; i < n-1; i++ {
        curr := words[i]
        next := words[i+1]
        if curr[len(curr)-1] != next[0] {
            return false
        }
    }
    return true
}