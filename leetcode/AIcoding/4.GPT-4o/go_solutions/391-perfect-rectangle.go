func isRectangleCover(rectangles [][]int) bool {
    pointCount := make(map[[2]int]int)
    areaSum := 0
    minX, minY := math.MaxInt32, math.MaxInt32
    maxX, maxY := math.MinInt32, math.MinInt32

    for _, rect := range rectangles {
        x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]
        areaSum += (x2 - x1) * (y2 - y1)
        minX = min(minX, x1)
        minY = min(minY, y1)
        maxX = max(maxX, x2)
        maxY = max(maxY, y2)

        points := [][2]int{
            {x1, y1}, {x2, y1}, {x1, y2}, {x2, y2},
        }
        for _, p := range points {
            pointCount[p]++
        }
    }

    expectedArea := (maxX - minX) * (maxY - minY)
    if areaSum != expectedArea {
        return false
    }

    corners := [][2]int{
        {minX, minY}, {maxX, minY}, {minX, maxY}, {maxX, maxY},
    }
    cornerCount := 0
    for _, corner := range corners {
        if pointCount[corner] == 1 {
            cornerCount++
        } else if pointCount[corner] != 0 {
            return false
        }
    }

    return cornerCount == 4 && len(pointCount) == 4
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