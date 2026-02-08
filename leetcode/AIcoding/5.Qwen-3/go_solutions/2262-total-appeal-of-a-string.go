package main

func appealSum(s string) int {
    last := make([]int, 26)
    for i := range last {
        last[i] = -1
    }
    res := 0
    total := 0
    for i := 0; i < len(s); i++ {
        c := int(s[i] - 'a')
        if last[c] != -1 {
            total += i - last[c]
        } else {
            total += i + 1
        }
        res += total
        last[c] = i
    }
    return res
}