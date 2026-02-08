package main

func canBeValid(s string) bool {
    if len(s)%2 != 0 {
        return false
    }
    open := 0
    close := 0
    for _, ch := range s {
        if ch == '(' {
            open++
        } else {
            close++
        }
        if open < close {
            return false
        }
    }
    return open == close
}