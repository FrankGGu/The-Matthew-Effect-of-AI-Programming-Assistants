package main

func reinitializePermutation(n int) int {
    pos := make([]int, n)
    for i := 0; i < n; i++ {
        pos[i] = i
    }
    res := 0
    for i := 0; i < n; i++ {
        if pos[i] == i {
            continue
        }
        for j := i; pos[j] != j; j = pos[j] {
            pos[j], pos[pos[j]] = pos[pos[j]], pos[j]
            res++
        }
    }
    return res
}