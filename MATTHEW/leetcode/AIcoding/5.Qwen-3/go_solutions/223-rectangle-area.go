package main

func computeArea(x1 int, y1 int, x2 int, y2 int, x3 int, y3 int, x4 int, y4 int) int {
    area1 := (x2 - x1) * (y2 - y1)
    area2 := (x4 - x3) * (y4 - y3)
    overlapX := 0
    overlapY := 0
    if x1 < x4 && x3 < x2 {
        overlapX = x2 - x3
    }
    if y1 < y4 && y3 < y2 {
        overlapY = y2 - y3
    }
    overlap := overlapX * overlapY
    return area1 + area2 - overlap
}