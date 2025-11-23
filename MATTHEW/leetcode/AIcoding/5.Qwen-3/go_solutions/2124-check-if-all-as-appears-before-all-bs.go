package main

func checkString(s string) bool {
    foundB := false
    for i := 0; i < len(s); i++ {
        if s[i] == 'b' {
            foundB = true
        } else if foundB && s[i] == 'a' {
            return false
        }
    }
    return true
}