func minDeletions(s string, k int) int {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }

    count := 0
    for _, v := range freq {
        if v > k {
            count += v - k
        }
    }
    return count
}