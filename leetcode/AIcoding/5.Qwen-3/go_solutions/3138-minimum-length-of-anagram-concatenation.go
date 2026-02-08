package main

func minAnagramConcatenation(s string, t string) int {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    for _, c := range t {
        count[c-'a']--
    }
    res := 0
    for i := 0; i < 26; i++ {
        if count[i] > 0 {
            res += count[i]
        }
    }
    return res
}