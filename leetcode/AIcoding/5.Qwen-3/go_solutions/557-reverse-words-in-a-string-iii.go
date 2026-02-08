package main

func reverseWords(s string) string {
    runes := []rune(s)
    n := len(runes)
    start := 0
    for i := 0; i < n; i++ {
        if runes[i] == ' ' {
            reverse(runes, start, i-1)
            start = i + 1
        }
    }
    reverse(runes, start, n-1)
    return string(runes)
}

func reverse(runes []rune, left, right int) {
    for left < right {
        runes[left], runes[right] = runes[right], runes[left]
        left++
        right--
    }
}