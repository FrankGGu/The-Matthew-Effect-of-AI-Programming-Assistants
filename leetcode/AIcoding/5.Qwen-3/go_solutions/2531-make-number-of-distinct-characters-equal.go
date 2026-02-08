package main

func isEqualFrequency(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }

    freq := make(map[int]bool)
    for _, v := range count {
        freq[v] = true
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

    if (keys[0] == 1 && freq[1] && len(count) == 1) || (keys[1] == 1 && freq[1] && len(count) == 1) {
        return true
    }

    if keys[0] == 1 && keys[1] == 2 {
        return true
    }

    if keys[0] == 2 && keys[1] == 1 {
        return true
    }

    return false
}