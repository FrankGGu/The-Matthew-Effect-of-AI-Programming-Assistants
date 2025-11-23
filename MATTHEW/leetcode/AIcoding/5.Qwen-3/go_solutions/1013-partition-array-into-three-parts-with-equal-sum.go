package main

func canThreeParts(s []int) bool {
    total := 0
    for _, v := range s {
        total += v
    }
    if total%3 != 0 {
        return false
    }
    target := total / 3
    count := 0
    current := 0
    for _, v := range s {
        current += v
        if current == target {
            count++
            current = 0
        }
    }
    return count >= 3
}