package main

func validPair(s string) bool {
    for i := 0; i < len(s)-1; i++ {
        if (s[i] == '0' && s[i+1] == '1') || (s[i] == '1' && s[i+1] == '0') {
            return true
        }
    }
    return false
}