func rearrange(s string, target string, k int) bool {
    sFreq := make(map[rune]int)
    targetFreq := make(map[rune]int)

    for _, r := range s {
        sFreq[r]++
    }

    for _, r := range target {
        targetFreq[r]++
    }

    for r, count := range targetFreq {
        if sFreq[r] < count {
            return false
        }
    }

    return true
}