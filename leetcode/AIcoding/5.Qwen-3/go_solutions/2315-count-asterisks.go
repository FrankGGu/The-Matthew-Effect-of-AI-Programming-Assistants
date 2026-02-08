package main

func countAsterisks(s string) int {
    count := 0
    inBold := false
    for _, c := range s {
        if c == '*' && !inBold {
            count++
        } else if c == '|' {
            inBold = !inBold
        }
    }
    return count
}