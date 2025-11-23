func minAreaFreeRect(points [][]int) float64 {
    pointSet := make(map[[2]int]struct{})
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = struct{}{}
    }

    var minArea float64 = math.MaxFloat64

    for i := 0; i < len(points); i++ {
        for j := i + 1; j < len(points); j++ {
            x1, y1 := points[i][0], points[i][1]
            x2, y2 := points[j][0], points[j][1]
            if (x1 == x2) || (y1 == y2) {
                continue
            }
            x3, y3 := x1, y2
            x4, y4 := x2, y1
            if _, ok1 := pointSet[[2]int{x3, y3}]; ok1 {
                if _, ok2 := pointSet[[2]int{x4, y4}]; ok2 {
                    area := math.Abs(float64((x1-x2)*(y1-y2)))
                    if area < minArea {
                        minArea = area
                    }
                }
            }
        }
    }

    if minArea == math.MaxFloat64 {
        return 0.0
    }
    return minArea
}