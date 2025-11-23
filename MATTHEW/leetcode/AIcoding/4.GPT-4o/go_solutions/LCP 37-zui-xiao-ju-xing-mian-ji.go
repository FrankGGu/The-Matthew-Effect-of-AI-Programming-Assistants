func minAreaRect(points [][]int) int {
    pointSet := make(map[[2]int]struct{})
    for _, point := range points {
        pointSet[[2]int{point[0], point[1]}] = struct{}{}
    }

    minArea := math.MaxInt32
    for i := 0; i < len(points); i++ {
        for j := i + 1; j < len(points); j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                continue
            }
            if _, exists1 := pointSet[[2]int{points[i][0], points[j][1]}]; exists1 {
                if _, exists2 := pointSet[[2]int{points[j][0], points[i][1]}]; exists2 {
                    area := abs(points[i][0]-points[j][0]) * abs(points[i][1]-points[j][1])
                    minArea = min(minArea, area)
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

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}