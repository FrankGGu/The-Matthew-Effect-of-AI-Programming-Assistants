package main

func nearestValidPoint(x int, y int, points [][]int) int {
    minDistance := -1
    resultIndex := -1
    for i, point := range points {
        if point[0] == x || point[1] == y {
            distance := abs(point[0]-x) + abs(point[1]-y)
            if minDistance == -1 || distance < minDistance {
                minDistance = distance
                resultIndex = i
            }
        }
    }
    return resultIndex
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}