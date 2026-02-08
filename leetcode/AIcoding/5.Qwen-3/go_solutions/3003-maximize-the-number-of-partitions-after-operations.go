package main

func maxPartitions(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }
    last := make(map[byte]int)
    for i := 0; i < n; i++ {
        last[s[i]] = i
    }
    res := 0
    prev := -1
    for i := 0; i < n; i++ {
        if last[s[i]] == i {
            res++
            prev = i
        } else {
            if i == last[s[i]] {
                res++
                prev = i
            }
        }
    }
    return res
}