package main

func countSpecialSubsequences(s string) int {
    var count0, count1, count2 int
    for _, c := range s {
        if c == '0' {
            count0++
        } else if c == '1' {
            count1 += count0
        } else if c == '2' {
            count2 += count1
        }
    }
    return count2
}