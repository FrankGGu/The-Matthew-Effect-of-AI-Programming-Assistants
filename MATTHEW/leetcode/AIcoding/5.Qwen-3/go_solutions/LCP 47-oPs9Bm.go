package main

func checkRecord(s string) bool {
    absent := 0
    for i := 0; i < len(s); i++ {
        if s[i] == 'A' {
            absent++
            if absent >= 2 {
                return false
            }
        } else if s[i] == 'L' && i+2 < len(s) && s[i+1] == 'L' && s[i+2] == 'L' {
            return false
        }
    }
    return true
}