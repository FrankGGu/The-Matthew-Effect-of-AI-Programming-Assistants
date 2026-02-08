package main

func countRepetitions(s string, k int) int {
    if k == 0 {
        return 0
    }
    count := 0
    m := len(s)
    for i := 0; i < m; i++ {
        if s[i] == 'a' {
            count++
        }
    }
    return count / k
}