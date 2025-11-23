func minOperations(s string) int {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }

    counts := make([]int, 0, len(freq))
    for _, count := range freq {
        counts = append(counts, count)
    }

    minOps := len(s)
    for target := 1; target <= len(s); target++ {
        ops := 0
        for _, count := range counts {
            if count < target {
                ops += count
            } else {
                ops += count - target
            }
        }
        minOps = min(minOps, ops)
    }

    return minOps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}