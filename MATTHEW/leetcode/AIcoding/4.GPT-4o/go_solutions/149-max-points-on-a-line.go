import "math"

func maxPoints(points [][]int) int {
    n := len(points)
    if n <= 2 {
        return n
    }

    maxPoints := 0
    for i := 0; i < n; i++ {
        slopes := make(map[float64]int)
        for j := 0; j < n; j++ {
            if i != j {
                dx := float64(points[j][0] - points[i][0])
                dy := float64(points[j][1] - points[i][1])
                slope := math.Inf(1)
                if dx != 0 {
                    slope = dy / dx
                }
                slopes[slope]++
            }
        }
        currentMax := 0
        for _, count := range slopes {
            if count > currentMax {
                currentMax = count
            }
        }
        maxPoints = max(maxPoints, currentMax+1)
    }
    return maxPoints
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}