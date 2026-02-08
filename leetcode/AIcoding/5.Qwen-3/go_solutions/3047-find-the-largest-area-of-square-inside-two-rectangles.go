package main

func largestSquareArea(rect1 []int, rect2 []int) int {
    x1, y1, x2, y2 := rect1[0], rect1[1], rect1[2], rect1[3]
    a1, b1, a2, b2 := rect2[0], rect2[1], rect2[2], rect2[3]

    overlapX := max(0, min(x2, a2)-max(x1, a1))
    overlapY := max(0, min(y2, b2)-max(y1, b1))

    side := min(overlapX, overlapY)
    return side * side
}