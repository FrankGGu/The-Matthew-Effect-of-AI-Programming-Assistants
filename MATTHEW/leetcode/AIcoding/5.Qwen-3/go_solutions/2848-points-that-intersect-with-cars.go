package main

func numberOfPoints(cars [][]int) int {
    points := make(map[int]bool)
    for _, car := range cars {
        start, end := car[0], car[1]
        for i := start; i <= end; i++ {
            points[i] = true
        }
    }
    return len(points)
}