package main

func maxDistance(points [][]int) int {
    n := len(points)
    maxDist := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            dx := points[i][0] - points[j][0]
            dy := points[i][1] - points[j][1]
            dist := dx*dx + dy*dy
            if dist > maxDist {
                maxDist = dist
            }
        }
    }
    return maxDist
}