func canConvertString(s string, t string, k int) bool {
    if len(s) != len(t) {
        return false
    }

    n := len(s)
    counts := make([]int, 26)
    for i := 0; i < n; i++ {
        diff := int(t[i] - s[i])
        if diff < 0 {
            diff += 26
        }

        if diff != 0 {
            counts[diff]++
        }
    }

    maxMoves := 0
    for i := 1; i < 26; i++ {
        movesNeeded := (counts[i] - 1) * 26 + i
        maxMoves = max(maxMoves, movesNeeded)
    }

    return maxMoves <= k
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}