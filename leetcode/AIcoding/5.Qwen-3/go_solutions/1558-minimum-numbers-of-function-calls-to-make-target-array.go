package main

func minNumberOperations(target []int) int {
    res := 0
    prev := 0
    for _, t := range target {
        if t > prev {
            res += t - prev
        }
        prev = t
    }
    return res
}