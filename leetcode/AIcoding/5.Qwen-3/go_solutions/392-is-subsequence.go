package main

func isSubsequence(s string, t string) bool {
    i := 0
    for i < len(s) && len(t) > 0 {
        if s[i] == t[0] {
            i++
        }
        t = t[1:]
    }
    return i == len(s)
}