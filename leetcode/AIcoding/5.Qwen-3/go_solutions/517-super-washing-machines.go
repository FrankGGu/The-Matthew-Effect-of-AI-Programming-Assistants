package main

func findMinMoves(s []int) int {
    total := 0
    for _, v := range s {
        total += v
    }
    if total%len(s) != 0 {
        return -1
    }
    avg := total / len(s)
    res := 0
    for i := 0; i < len(s); i++ {
        s[i] -= avg
    }
    for i := 0; i < len(s); i++ {
        if i > 0 {
            s[i] += s[i-1]
        }
        if s[i] < 0 {
            res = max(res, -s[i])
        } else {
            res = max(res, s[i])
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}