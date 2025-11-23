import "math"

func nearestValidPoint(x int, y int, points [][]int) int {
    minDistance := math.MaxInt32
    minIndex := -1

    for i, p := range points {
        px, py := p[0], p[1]

        if px == x || py == y {
            // This point is valid
            dist := abs(x-px) + abs(y-py)

            if dist < minDistance {
                minDistance = dist
                minIndex = i
            }
        }
    }

    return minIndex
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}