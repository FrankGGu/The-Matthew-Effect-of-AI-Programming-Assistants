package main

func countGoodPartitions(s string) int {
    last := make(map[byte]int)
    for i, c := range s {
        last[byte(c)] = i
    }

    res := 0
    prev := -1
    for i, c := range s {
        if last[byte(c)] == i {
            res++
        } else {
            if i == prev {
                res++
            }
        }
        prev = max(prev, last[byte(c)])
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}