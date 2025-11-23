import "math"

func minCostConnectPoints(points [][]int) int {
    n := len(points)

    minDist := make([]int, n)
    for i := range minDist {
        minDist[i] = math.MaxInt32
    }

    visited := make([]bool, n)

    minDist[0] = 0 
    totalCost := 0

    for i := 0; i < n; i++ {
        minCurrentDist := math.MaxInt32
        currentPoint := -1

        for j := 0; j < n; j++ {
            if !visited[j] && minDist[j] < minCurrentDist {
                minCurrentDist = minDist[j]
                currentPoint = j
            }
        }

        if currentPoint == -1 {
            break 
        }

        visited[currentPoint] = true
        totalCost += minCurrentDist

        for j := 0; j < n; j++ {
            if !visited[j] {
                dist := abs(points[currentPoint][0]-points[j][0]) + abs(points[currentPoint][1]-points[j][1])
                if dist < minDist[j] {
                    minDist[j] = dist
                }
            }
        }
    }

    return totalCost
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}