func nearestValidPoint(x int, y int, points [][]int) int {
    minDist := -1
    index := -1
    for i, point := range points {
        if point[0] == x || point[1] == y {
            dist := abs(point[0]-x) + abs(point[1]-y)
            if minDist == -1 || dist < minDist {
                minDist = dist
                index = i
            } else if dist == minDist && i < index {
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