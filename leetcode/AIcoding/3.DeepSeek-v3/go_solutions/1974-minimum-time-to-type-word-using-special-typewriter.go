func minTimeToType(word string) int {
    current := 'a'
    time := 0
    for _, c := range word {
        diff := abs(int(c - current))
        time += min(diff, 26 - diff) + 1
        current = c
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