package main

func reverseStr(s string, k int) string {
    sRunes := []rune(s)
    for i := 0; i < len(sRunes); i += 2 * k {
        left := i
        right := i + k - 1
        if right >= len(sRunes) {
            right = len(sRunes) - 1
        }
        for left < right {
            sRunes[left], sRunes[right] = sRunes[right], sRunes[left]
            left++
            right--
        }
    }
    return string(sRunes)
}