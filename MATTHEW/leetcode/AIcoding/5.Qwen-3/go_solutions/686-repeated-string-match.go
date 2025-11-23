package main

func repeatedStringMatch(a string, b string) int {
    if a == "" {
        return -1
    }
    count := 1
    s := a
    for !contains(s, b) {
        s += a
        count++
        if len(s) > len(b)+len(a) {
            return -1
        }
    }
    return count
}

func contains(s string, sub string) bool {
    return len(s) >= len(sub) && (s == sub || s[1:] == sub || contains(s[1:], sub))
}