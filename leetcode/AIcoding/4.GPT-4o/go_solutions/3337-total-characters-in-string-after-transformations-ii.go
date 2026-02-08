func transformedStringLength(s string, transformations [][]string) int {
    charCount := make(map[rune]int)

    for _, ch := range s {
        charCount[ch]++
    }

    for _, t := range transformations {
        if len(t) != 2 {
            continue
        }
        from, to := rune(t[0][0]), rune(t[1][0])
        if count, exists := charCount[from]; exists {
            charCount[to] += count
            delete(charCount, from)
        }
    }

    totalCount := 0
    for _, count := range charCount {
        totalCount += count
    }

    return totalCount
}