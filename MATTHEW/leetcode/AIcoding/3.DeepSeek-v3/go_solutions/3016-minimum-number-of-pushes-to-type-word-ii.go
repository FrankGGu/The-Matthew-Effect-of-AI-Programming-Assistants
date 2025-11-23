func minimumPushes(word string) int {
    freq := make([]int, 26)
    for _, c := range word {
        freq[c-'a']++
    }
    sort.Slice(freq, func(i, j int) bool {
        return freq[i] > freq[j]
    })
    res := 0
    for i := 0; i < 26; i++ {
        if freq[i] == 0 {
            break
        }
        res += freq[i] * ((i / 8) + 1)
    }
    return res
}