func minSteps(s string, t string) int {
    freq := make(map[rune]int)
    for _, r := range s {
        freq[r]++
    }
    for _, r := range t {
        freq[r]--
    }
    count := 0
    for _, v := range freq {
        if v > 0 {
            count += v
        }
    }
    return count
}