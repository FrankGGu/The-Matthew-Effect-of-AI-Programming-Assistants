package main

func wordPattern(pattern string, s string) bool {
    words := make(map[string]string)
    seen := make(map[string]bool)
    wordList := strings.Split(s, " ")
    if len(pattern) != len(wordList) {
        return false
    }
    for i := 0; i < len(pattern); i++ {
        p := string(pattern[i])
        w := wordList[i]
        if val, ok := words[p]; ok {
            if val != w {
                return false
            }
        } else {
            if seen[w] {
                return false
            }
            words[p] = w
            seen[w] = true
        }
    }
    return true
}