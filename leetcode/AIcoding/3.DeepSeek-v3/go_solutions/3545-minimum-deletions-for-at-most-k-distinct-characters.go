func minDeletions(s string, k int) int {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }
    counts := make([]int, 0, len(freq))
    for _, v := range freq {
        counts = append(counts, v)
    }
    sort.Ints(counts)
    res := 0
    for i := 0; i < len(counts); i++ {
        if counts[i] > k {
            if i == 0 {
                res += counts[i] - k
                counts[i] = k
            } else {
                target := min(k, counts[i-1])
                if target == 0 {
                    res += counts[i]
                    counts[i] = 0
                } else {
                    res += counts[i] - target
                    counts[i] = target
                }
            }
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}