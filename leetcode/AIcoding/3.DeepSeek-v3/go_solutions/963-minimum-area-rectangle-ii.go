func minAreaFreeRect(points [][]int) float64 {
    n := len(points)
    if n < 4 {
        return 0
    }

    pointSet := make(map[[2]int]bool)
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = true
    }

    minArea := math.MaxFloat64

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            for k := 0; k < n; k++ {
                if i == k || j == k {
                    continue
                }
                p1 := points[i]
                p2 := points[j]
                p3 := points[k]
                x1, y1 := p1[0], p1[1]
                x2, y2 := p2[0], p2[1]
                x3, y3 := p3[0], p3[1]

                if (x2-x1)*(x3-x1)+(y2-y1)*(y3-y1) != 0 {
                    continue
                }

                x4 := x2 + x3 - x1
                y4 := y2 + y3 - y1

                if pointSet[[2]int{x4, y4}] {
                    area := math.Sqrt(float64((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))) * 
                            math.Sqrt(float64((x3-x1)*(x3-x1)+(y3-y1)*(y3-y1)))
                    if area < minArea {
                        minArea = area
                    }
                }
            }
        }
    }

    if minArea == math.MaxFloat64 {
        return 0
    }
    return minArea
}