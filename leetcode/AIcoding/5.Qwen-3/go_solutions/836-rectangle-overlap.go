package main

func computeArea(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2 int) int {
    overlapX := 0
    if ax1 < bx2 && ax2 > bx1 {
        overlapX = ax2 - ax1
    }
    overlapY := 0
    if ay1 < by2 && ay2 > by1 {
        overlapY = ay2 - ay1
    }
    overlapArea := overlapX * overlapY

    areaA := (ax2 - ax1) * (ay2 - ay1)
    areaB := (bx2 - bx1) * (by2 - by1)

    return areaA + areaB - overlapArea
}