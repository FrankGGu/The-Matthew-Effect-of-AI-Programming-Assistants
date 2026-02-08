func findKthNumber(n int, k int) int {
    current := 1
    k--

    for k > 0 {
        steps := 0
        first := current
        last := current + 1

        for first <= n {
            steps += min(n+1, last) - first
            first *= 10
            last *= 10
        }

        if steps <= k {
            k -= steps
            current++
        } else {
            current *= 10
            k--
        }
    }

    return current
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}