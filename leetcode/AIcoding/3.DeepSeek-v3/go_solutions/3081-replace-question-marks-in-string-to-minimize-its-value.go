func minimizeStringValue(s string) string {
    count := make([]int, 26)
    questionMarks := 0
    for _, ch := range s {
        if ch != '?' {
            count[ch-'a']++
        } else {
            questionMarks++
        }
    }

    res := []rune(s)
    for i := 0; i < questionMarks; i++ {
        minCount := int(^uint(0) >> 1)
        var minChar rune
        for c := 0; c < 26; c++ {
            if count[c] < minCount {
                minCount = count[c]
                minChar = rune('a' + c)
            }
        }
        count[minChar-'a']++
        for j := 0; j < len(res); j++ {
            if res[j] == '?' {
                res[j] = minChar
                break
            }
        }
    }
    return string(res)
}