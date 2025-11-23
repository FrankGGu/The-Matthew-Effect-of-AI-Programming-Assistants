func canConstruct(s string, k int) bool {
    if len(s) < k {
        return false
    }
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }
    oddCount := 0
    for _, count := range freq {
        if count % 2 != 0 {
            oddCount++
        }
    }
    return oddCount <= k
}