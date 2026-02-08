func closeStrings(word1 string, word2 string) bool {
    if len(word1) != len(word2) {
        return false
    }

    count1 := make([]int, 26)
    count2 := make([]int, 26)
    for i := 0; i < len(word1); i++ {
        count1[word1[i]-'a']++
        count2[word2[i]-'a']++
    }

    freq1 := make(map[int]int)
    freq2 := make(map[int]int)
    for _, v := range count1 {
        if v > 0 {
            freq1[v]++
        }
    }
    for _, v := range count2 {
        if v > 0 {
            freq2[v]++
        }
    }

    if len(freq1) != len(freq2) {
        return false
    }

    for k, v := range freq1 {
        if freq2[k] != v {
            return false
        }
    }

    return true
}