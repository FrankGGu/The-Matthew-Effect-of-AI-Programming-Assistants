package main

func minTimeToType(word string) int {
    time := 0
    prev := 'a'
    for _, c := range word {
        diff := int32(abs(int(c - prev)))
        time += min(diff, 26-diff)
        time += 1
        prev = c
    }
    return time
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}