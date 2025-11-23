package main

func removeSticks(s []int) int {
    sort.Ints(s)
    res := 0
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] != s[i-1] {
            res += s[i] - s[i-1]
        }
    }
    return res
}