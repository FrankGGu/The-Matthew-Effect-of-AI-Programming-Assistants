func equalFrequency(word string) bool {
    freq := make(map[rune]int)
    for _, c := range word {
        freq[c]++
    }

    for c := range freq {
        freq[c]--
        if checkEqual(freq) {
            return true
        }
        freq[c]++
    }

    return false
}

func checkEqual(freq map[rune]int) bool {
    val := -1
    for _, v := range freq {
        if v == 0 {
            continue
        }
        if val == -1 {
            val = v
        } else if v != val {
            return false
        }
    }
    return true
}