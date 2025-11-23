package main

import "math"

func numPoints(points [][]int, r int) []int {
    res := make([]int, len(points))
    for i := 0; i < len(points); i++ {
        x1, y1 := points[i][0], points[i][1]
        count := 0
        for j := 0; j < len(points); j++ {
            x2, y2 := points[j][0], points[j][1]
            if int(math.Pow(float64(x1-x2), 2)+math.Pow(float64(y1-y2), 2)) <= r*r {
                count++
            }
        }
        res[i] = count
    }
    return res
}