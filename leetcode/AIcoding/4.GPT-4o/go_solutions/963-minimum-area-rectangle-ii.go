func minAreaRect(points [][]int) int {
    pointSet := make(map[[2]int]struct{})
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = struct{}{}
    }

    minArea := math.MaxInt32
    for i := 0; i < len(points); i++ {
        for j := i + 1; j < len(points); j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                continue
            }
            if _, ok1 := pointSet[[2]int{points[i][0], points[j][1]}]; ok1 {
                if _, ok2 := pointSet[[2]int{points[j][0], points[i][1]}]; ok2 {
                    area := abs(points[i][0]-points[j][0]) * abs(points[i][1]-points[j][1])
                    if area > 0 && area < minArea {
                        minArea = area
                    }
                }
            }
        }
    }

    if minArea == math.MaxInt32 {
        return 0
    }
    return minArea
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}