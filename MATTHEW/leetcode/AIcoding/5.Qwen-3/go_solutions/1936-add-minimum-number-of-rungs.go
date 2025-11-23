package main

func addRungs(rungs []int, dist int) int {
    res := 0
    prev := 0
    for _, h := range rungs {
        if h-prev > dist {
            res += (h - prev - 1) / dist
        }
        prev = h
    }
    return res
}