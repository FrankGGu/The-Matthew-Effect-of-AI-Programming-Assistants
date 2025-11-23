func checkOverlap(radius int, xCenter int, yCenter int, x1 int, y1 int, x2 int, y2 int) bool {
    closestX := max(x1, min(xCenter, x2))
    closestY := max(y1, min(yCenter, y2))

    distanceX := xCenter - closestX
    distanceY := yCenter - closestY

    return distanceX*distanceX + distanceY*distanceY <= radius*radius
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}