package main

func furthestDistanceFromOrigin(x int, y int, s string) int {
    var countLeft, countRight, countOther int
    for _, ch := range s {
        if ch == 'L' {
            countLeft++
        } else if ch == 'R' {
            countRight++
        } else {
            countOther++
        }
    }
    return abs(x - y + countOther)
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}