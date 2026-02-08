package main

func isRectangleCover(rects [][]int) bool {
    minX, minY := math.MaxInt32, math.MaxInt32
    maxX, maxY := math.MinInt32, math.MinInt32
    area := 0
    points := make(map[[2]int]bool)
    for _, r := range rects {
        x1, y1, x2, y2 := r[0], r[1], r[2], r[3]
        minX = min(minX, x1)
        minY = min(minY, y1)
        maxX = max(maxX, x2)
        maxY = max(maxY, y2)
        area += (x2 - x1) * (y2 - y1)
        for _, p := range [4][2]int{{x1, y1}, {x1, y2}, {x2, y1}, {x2, y2}} {
            if points[p] {
                delete(points, p)
            } else {
                points[p] = true
            }
        }
    }
    expectedArea := (maxX - minX) * (maxY - minY)
    if area != expectedArea {
        return false
    }
    if len(points) != 4 {
        return false
    }
    for _, p := range [4][2]int{{minX, minY}, {minX, maxY}, {maxX, minY}, {maxX, maxY}} {
        if !points[p] {
            return false
        }
    }
    return true
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