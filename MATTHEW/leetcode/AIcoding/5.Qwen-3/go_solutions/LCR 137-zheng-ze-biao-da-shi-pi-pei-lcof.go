package main

func validSubstring(s string, t string) bool {
    if len(s) < len(t) {
        return false
    }
    tCount := make(map[rune]int)
    window := make(map[rune]int)
    for _, c := range t {
        tCount[c]++
    }
    required := len(tCount)
    formed := 0
    left, right := 0, 0
    for right < len(s) {
        c := rune(s[right])
        window[c]++
        if window[c] == tCount[c] {
            formed++
        }
        right++
        for formed == required {
            if right-left == len(t) {
                return true
            }
            leftC := rune(s[left])
            window[leftC]--
            if window[leftC] < tCount[leftC] {
                formed--
            }
            left++
        }
    }
    return false
}