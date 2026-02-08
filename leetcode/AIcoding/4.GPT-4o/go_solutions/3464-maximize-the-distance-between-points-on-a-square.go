func maxDistance(points [][]int) int {
    minX, minY := math.MaxInt32, math.MaxInt32
    maxX, maxY := math.MinInt32, math.MinInt32

    for _, point := range points {
        x, y := point[0], point[1]
        if x < minX {
            minX = x
        }
        if x > maxX {
            maxX = x
        }
        if y < minY {
            minY = y
        }
        if y > maxY {
            maxY = y
        }
    }

    return max(maxX-minX, maxY-minY)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}