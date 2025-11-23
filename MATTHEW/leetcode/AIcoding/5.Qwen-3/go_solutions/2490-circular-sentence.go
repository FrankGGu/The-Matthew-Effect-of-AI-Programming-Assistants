package main

func isCircularSentence(sentence string) bool {
    words := strings.Split(sentence, " ")
    n := len(words)
    if n == 0 {
        return true
    }
    for i := 0; i < n; i++ {
        if len(words[i]) == 0 || len(words[(i+1)%n]) == 0 {
            return false
        }
        if words[i][len(words[i])-1] != words[(i+1)%n][0] {
            return false
        }
    }
    return true
}