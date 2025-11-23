func minAreaRect(points [][]int) int {
    pointSet := make(map[[2]int]bool)
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = true
    }

    minArea := math.MaxInt32

    for i := 0; i < len(points); i++ {
        for j := i + 1; j < len(points); j++ {
            p1 := points[i]
            p2 := points[j]

            if p1[0] == p2[0] || p1[1] == p2[1] {
                continue
            }

            if pointSet[[2]int{p1[0], p2[1]}] && pointSet[[2]int{p2[0], p1[1]}] {
                area := abs(p1[0] - p2[0]) * abs(p1[1] - p2[1])
                if area < minArea {
                    minArea = area
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