package main

func minTimeToVisitAllPoints(targetX int, targetY int) int {
    return abs(targetX) + abs(targetY)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}