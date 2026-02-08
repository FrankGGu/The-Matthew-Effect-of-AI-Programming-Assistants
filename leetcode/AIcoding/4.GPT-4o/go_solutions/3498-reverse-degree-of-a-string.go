func reverseDegree(s string) string {
    count := make(map[rune]int)
    for _, ch := range s {
        count[ch]++
    }

    result := make([]rune, 0, len(s))
    for _, ch := range s {
        if count[ch] > 0 {
            result = append(result, ch)
            count[ch] = -1
        }
    }

    return string(result)
}