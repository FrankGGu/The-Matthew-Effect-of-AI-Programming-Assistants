func reverseStr(s string, k int) string {
    runes := []rune(s)
    n := len(runes)

    for i := 0; i < n; i += 2 * k {
        left, right := i, min(i+k-1, n-1)
        for left < right {
            runes[left], runes[right] = runes[right], runes[left]
            left++
            right--
        }
    }

    return string(runes)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}