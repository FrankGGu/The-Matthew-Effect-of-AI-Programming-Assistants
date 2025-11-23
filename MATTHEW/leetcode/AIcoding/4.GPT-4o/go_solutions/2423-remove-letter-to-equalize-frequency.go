func equalFrequency(word string) bool {
    freq := make(map[rune]int)
    for _, ch := range word {
        freq[ch]++
    }

    freqCount := make(map[int]int)
    for _, count := range freq {
        freqCount[count]++
    }

    if len(freqCount) == 1 {
        for count := range freqCount {
            if count == 1 || freqCount[count] == 1 {
                return true
            }
        }
    }

    if len(freqCount) == 2 {
        keys := make([]int, 0, len(freqCount))
        for k := range freqCount {
            keys = append(keys, k)
        }
        a, b := keys[0], keys[1]
        if (freqCount[a] == 1 && (a-1 == b || a == 1)) || (freqCount[b] == 1 && (b-1 == a || b == 1)) {
            return true
        }
    }

    return false
}