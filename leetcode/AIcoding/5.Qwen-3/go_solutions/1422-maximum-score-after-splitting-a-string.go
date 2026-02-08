package main

func maxScore(s string) int {
    left := 0
    right := 0
    for _, c := range s {
        if c == '1' {
            right++
        }
    }
    max := 0
    for i := 0; i < len(s)-1; i++ {
        if s[i] == '0' {
            left++
        } else {
            right--
        }
        current := left + right
        if current > max {
            max = current
        }
    }
    return max
}