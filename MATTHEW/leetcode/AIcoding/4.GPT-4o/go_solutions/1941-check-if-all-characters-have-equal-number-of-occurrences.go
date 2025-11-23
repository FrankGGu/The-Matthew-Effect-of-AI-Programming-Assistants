func haveEqualOccurrences(s string) bool {
    count := make(map[rune]int)
    for _, char := range s {
        count[char]++
    }

    occurrences := make(map[int]int)
    for _, freq := range count {
        occurrences[freq]++
    }

    return len(occurrences) == 1 || (len(occurrences) == 2 && (occurrences[1] == 1 || occurrences[1] == 1))
}