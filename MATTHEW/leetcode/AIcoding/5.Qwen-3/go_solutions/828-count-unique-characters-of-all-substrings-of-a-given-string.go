package main

func uniqueLetterString(s string) int {
    pre := make([]int, 26)
    curr := make([]int, 26)
    for i := range pre {
        pre[i] = -1
    }
    res := 0
    for i, c := range s {
        idx := int(c - 'a')
        if pre[idx] != -1 {
            curr[idx] = i - pre[idx]
        } else {
            curr[idx] = i + 1
        }
        res += curr[idx]
        pre[idx] = i
    }
    return res
}