package main

func minAdditions(s string) int {
    res := 0
    open := 0
    for _, c := range s {
        if c == '(' {
            open++
        } else {
            if open > 0 {
                open--
            } else {
                res++
            }
        }
    }
    return res + open
}