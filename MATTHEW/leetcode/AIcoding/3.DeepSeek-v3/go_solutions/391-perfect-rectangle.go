func isRectangleCover(rectangles [][]int) bool {
    area := 0
    minX, minY, maxX, maxY := rectangles[0][0], rectangles[0][1], rectangles[0][2], rectangles[0][3]
    pointCount := make(map[[2]int]int)

    for _, rect := range rectangles {
        x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]
        area += (x2 - x1) * (y2 - y1)

        if x1 < minX {
            minX = x1
        }
        if y1 < minY {
            minY = y1
        }
        if x2 > maxX {
            maxX = x2
        }
        if y2 > maxY {
            maxY = y2
        }

        pointCount[[2]int{x1, y1}]++
        pointCount[[2]int{x1, y2}]++
        pointCount[[2]int{x2, y1}]++
        pointCount[[2]int{x2, y2}]++
    }

    if area != (maxX - minX) * (maxY - minY) {
        return false
    }

    corners := [][2]int{{minX, minY}, {minX, maxY}, {maxX, minY}, {maxX, maxY}}
    for _, corner := range corners {
        if count, exists := pointCount[corner]; !exists || count != 1 {
            return false
        }
        delete(pointCount, corner)
    }

    for _, count := range pointCount {
        if count != 2 && count != 4 {
            return false
        }
    }

    return true
}