func checkOverlap(circle []int, rectangle []int) bool {
    circleX, circleY, radius := circle[0], circle[1], circle[2]
    recLeft, recRight, recBottom, recTop := rectangle[0], rectangle[2], rectangle[1], rectangle[3]

    closestX := max(recLeft, min(circleX, recRight))
    closestY := max(recBottom, min(circleY, recTop))

    distanceX := circleX - closestX
    distanceY := circleY - closestY

    return (distanceX * distanceX + distanceY * distanceY) <= (radius * radius)
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