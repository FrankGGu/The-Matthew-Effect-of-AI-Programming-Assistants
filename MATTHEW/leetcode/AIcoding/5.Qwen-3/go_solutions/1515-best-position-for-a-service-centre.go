package main

func bestCoordinate(sc *[][]int) []int {
    type Point struct {
        x, y int
    }
    var points []Point
    for _, s := range *sc {
        points = append(points, Point{s[0], s[1]})
    }
    minDist := 1e9
    res := []int{0, 0}
    for i := 0; i < 51; i++ {
        for j := 0; j < 51; j++ {
            dist := 0
            for _, p := range points {
                dist += abs(p.x-i) + abs(p.y-j)
            }
            if dist < minDist {
                minDist = dist
                res = []int{i, j}
            }
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}