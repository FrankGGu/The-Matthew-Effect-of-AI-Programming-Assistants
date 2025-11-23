package main

func maxPointsInsideOctagon(points [][]int, r int) int {
    n := len(points)
    maxCount := 0

    for i := 0; i < n; i++ {
        x1, y1 := points[i][0], points[i][1]
        count := 0
        for j := 0; j < n; j++ {
            x2, y2 := points[j][0], points[j][1]
            dx := x2 - x1
            dy := y2 - y1
            distSq := dx*dx + dy*dy
            if distSq <= r*r {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
        }
    }

    return maxCount
}