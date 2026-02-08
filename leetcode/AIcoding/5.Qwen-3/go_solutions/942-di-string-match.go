package main

func diStringMatch(s string) []int {
    n := len(s)
    low, high := 0, n
    result := make([]int, n+1)
    for i := 0; i < n; i++ {
        if s[i] == 'I' {
            result[i] = low
            low++
        } else {
            result[i] = high
            high--
        }
    }
    result[n] = low
    return result
}