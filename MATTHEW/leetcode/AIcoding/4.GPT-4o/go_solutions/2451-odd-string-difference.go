func oddString(words []string) string {
    diff := func(s string) []int {
        res := make([]int, len(s)-1)
        for i := 1; i < len(s); i++ {
            res[i-1] = int(s[i]) - int(s[i-1])
        }
        return res
    }

    counts := make(map[string]int)
    for _, word := range words {
        d := diff(word)
        counts[string(d)]++
    }

    for _, word := range words {
        d := diff(word)
        if counts[string(d)] == 1 {
            return word
        }
    }

    return ""
}