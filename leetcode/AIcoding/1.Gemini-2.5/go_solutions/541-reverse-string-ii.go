package main

func reverseStr(s string, k int) string {
    chars := []rune(s)
    n := len(chars)

    for i := 0; i < n; i += 2 * k {
        left := i
        right := min(i + k - 1, n - 1)

        for left < right {
            chars[left], chars[right] = chars[right], chars[left]
            left++
            right--
        }
    }

    return string(chars)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}