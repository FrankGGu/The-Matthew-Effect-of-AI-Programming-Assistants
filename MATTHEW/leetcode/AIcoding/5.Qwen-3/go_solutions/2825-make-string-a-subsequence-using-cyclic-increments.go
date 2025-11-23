package main

func canMakeSubsequence(s string, t string) bool {
    i, j := 0, 0
    for i < len(s) && j < len(t) {
        if s[i] == t[j] {
            i++
            j++
        } else {
            nextChar := func(c byte) byte {
                if c == 'z' {
                    return 'a'
                }
                return c + 1
            }
            if nextChar(s[i]) == t[j] {
                i++
                j++
            } else {
                i++
            }
        }
    }
    return j == len(t)
}