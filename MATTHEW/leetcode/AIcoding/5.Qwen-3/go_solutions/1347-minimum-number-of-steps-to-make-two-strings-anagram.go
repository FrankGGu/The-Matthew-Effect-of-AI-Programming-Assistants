package main

func minSteps(s string, t string) int {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    for _, c := range t {
        count[c-'a']--
    }
    res := 0
    for _, v := range count {
        if v > 0 {
            res += v
        }
    }
    return res
}