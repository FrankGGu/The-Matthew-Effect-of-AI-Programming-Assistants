func isValidWord(word string) bool {
    count := make(map[rune]int)
    for _, r := range word {
        count[r]++
    }

    freq := make(map[int]int)
    for _, c := range count {
        freq[c]++
    }

    if len(freq) == 1 {
        return true
    }

    if len(freq) > 2 {
        return false
    }

    keys := make([]int, 0, len(freq))
    for k := range freq {
        keys = append(keys, k)
    }

    if (keys[0] == 1 && freq[keys[0]] == 1) || (keys[1] == 1 && freq[keys[1]] == 1) {
        return true
    }

    if (keys[0] - keys[1] == 1 && freq[keys[0]] == 1) || (keys[1] - keys[0] == 1 && freq[keys[1]] == 1) {
        return true
    }

    return false
}