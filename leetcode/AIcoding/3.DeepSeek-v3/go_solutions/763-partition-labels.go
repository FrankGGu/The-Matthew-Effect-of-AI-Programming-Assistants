func partitionLabels(s string) []int {
    lastOccurrence := make(map[rune]int)
    for i, ch := range s {
        lastOccurrence[ch] = i
    }

    var result []int
    start, end := 0, 0
    for i, ch := range s {
        if lastOccurrence[ch] > end {
            end = lastOccurrence[ch]
        }
        if i == end {
            result = append(result, end - start + 1)
            start = end + 1
        }
    }
    return result
}