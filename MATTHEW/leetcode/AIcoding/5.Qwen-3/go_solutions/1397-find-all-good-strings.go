package main

func numberOfGoodStrings(possibleCharacters string, forbiddenStrings []string, minLength int, maxLength int, minFrequency int) int {
    forbidden := make(map[string]bool)
    for _, s := range forbiddenStrings {
        forbidden[s] = true
    }

    var count int
    var dfs func(string, int)
    dfs = func(s string, freq int) {
        if len(s) > maxLength {
            return
        }
        if len(s) >= minLength && freq >= minFrequency {
            count++
        }
        for _, c := range possibleCharacters {
            newS := s + string(c)
            newFreq := freq
            if len(s) > 0 && s[len(s)-1] == byte(c) {
                newFreq++
            } else {
                newFreq = 1
            }
            if !forbidden[newS] {
                dfs(newS, newFreq)
            }
        }
    }
    dfs("", 0)
    return count
}