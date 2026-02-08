func minimumRecolors(blocks string, k int) int {
    n := len(blocks)
    minRecolors := k
    currentRecolors := 0

    for i := 0; i < n; i++ {
        if blocks[i] == 'W' {
            currentRecolors++
        }
        if i >= k {
            if blocks[i-k] == 'W' {
                currentRecolors--
            }
        }
        if i >= k-1 {
            minRecolors = min(minRecolors, currentRecolors)
        }
    }

    return minRecolors
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}