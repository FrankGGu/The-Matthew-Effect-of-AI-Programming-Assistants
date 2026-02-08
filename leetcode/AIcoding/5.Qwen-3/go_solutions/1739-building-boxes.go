package main

func minBoxes(n int) int {
    if n == 0 {
        return 0
    }
    level := 1
    total := 0
    for total < n {
        total += level
        if total >= n {
            break
        }
        level++
    }
    return level
}