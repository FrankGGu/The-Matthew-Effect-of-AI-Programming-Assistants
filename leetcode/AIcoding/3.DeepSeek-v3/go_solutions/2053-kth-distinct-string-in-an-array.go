func kthDistinct(arr []string, k int) string {
    freq := make(map[string]int)
    for _, s := range arr {
        freq[s]++
    }
    count := 0
    for _, s := range arr {
        if freq[s] == 1 {
            count++
            if count == k {
                return s
            }
        }
    }
    return ""
}