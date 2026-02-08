func closeStrings(word1 string, word2 string) bool {
    if len(word1) != len(word2) {
        return false
    }

    freq1 := make([]int, 26)
    freq2 := make([]int, 26)
    set1 := make([]bool, 26)
    set2 := make([]bool, 26)

    for _, ch := range word1 {
        freq1[ch - 'a']++
        set1[ch - 'a'] = true
    }

    for _, ch := range word2 {
        freq2[ch - 'a']++
        set2[ch - 'a'] = true
    }

    for i := 0; i < 26; i++ {
        if set1[i] != set2[i] {
            return false
        }
    }

    sort.Ints(freq1)
    sort.Ints(freq2)

    for i := 0; i < 26; i++ {
        if freq1[i] != freq2[i] {
            return false
        }
    }

    return true
}