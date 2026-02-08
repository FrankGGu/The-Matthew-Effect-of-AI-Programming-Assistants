package main

func shiftDistance(s string, t string) int {
    n := len(s)
    m := len(t)
    if n != m {
        return -1
    }
    for i := 0; i < n; i++ {
        if (s[i] - t[i] + 26) % 26 != 0 {
            return -1
        }
    }
    return 0
}