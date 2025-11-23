package main

func numberOfSubstring(s string) int {
    count := 0
    lastOne := -1
    for i, c := range s {
        if c == '1' {
            lastOne = i
            count += lastOne + 1
        }
    }
    return count
}