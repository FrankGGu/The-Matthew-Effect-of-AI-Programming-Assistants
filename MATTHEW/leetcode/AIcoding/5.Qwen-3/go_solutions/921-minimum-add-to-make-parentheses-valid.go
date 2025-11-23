package main

func minAddToMakeValid(s string) int {
    left := 0
    right := 0
    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            left++
        } else {
            if left > 0 {
                left--
            } else {
                right++
            }
        }
    }
    return left + right
}