func shortestCompletingWord(licensePlate string, words []string) string {
    count := func(s string) [26]int {
        res := [26]int{}
        for _, c := range s {
            if c >= 'a' && c <= 'z' {
                res[c-'a']++
            } else if c >= 'A' && c <= 'Z' {
                res[c-'A']++
            }
        }
        return res
    }

    target := count(licensePlate)
    minLen := 16
    res := ""

    for _, word := range words {
        if len(word) >= minLen {
            continue
        }
        wordCount := count(word)
        match := true
        for i := 0; i < 26; i++ {
            if wordCount[i] < target[i] {
                match = false
                break
            }
        }
        if match {
            minLen = len(word)
            res = word
        }
    }

    return res
}