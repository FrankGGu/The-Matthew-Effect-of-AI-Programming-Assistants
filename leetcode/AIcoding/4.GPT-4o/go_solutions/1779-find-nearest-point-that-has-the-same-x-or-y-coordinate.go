func nearestValidPoint(x int, y int, points [][]int) int {
    minDist := int(1e9)
    index := -1

    for i, point := range points {
        if point[0] == x || point[1] == y {
            dist := abs(point[0]-x) + abs(point[1]-y)
            if dist < minDist {
                minDist = dist
                index = i
            }
        }
    }

    return index
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}