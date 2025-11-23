package main

func checkValidString(s string) bool {
    low, high := 0, 0
    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            low++
            high++
        } else if s[i] == ')' {
            low--
            high--
        } else {
            low--
            high++
        }
        if high < 0 {
            return false
        }
        if low < 0 {
            low = 0
        }
    }
    return low == 0
}