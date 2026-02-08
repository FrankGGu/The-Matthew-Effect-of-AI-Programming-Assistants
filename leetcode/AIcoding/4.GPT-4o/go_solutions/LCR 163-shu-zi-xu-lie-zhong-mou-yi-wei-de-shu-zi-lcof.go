func findKthNumber(n int, k int) int {
    curr, count, step := 1, 0, 0

    for count + step < k {
        step = 0
        first := curr
        last := curr + 1

        for first <= n {
            step += min(n+1, last) - first
            first *= 10
            last *= 10
        }

        if count + step < k {
            curr++
            count += step
        } else {
            curr *= 10
            count++
        }
    }

    return curr
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}