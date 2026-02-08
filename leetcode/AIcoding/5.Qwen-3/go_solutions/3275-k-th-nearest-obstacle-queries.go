package main

func closestObstacles(x []int, y []int, queries []int) []int {
    type Point struct {
        x, y int
    }
    obstacles := make([]Point, len(x))
    for i := 0; i < len(x); i++ {
        obstacles[i] = Point{x[i], y[i]}
    }

    res := make([]int, len(queries))
    for i := 0; i < len(queries); i++ {
        k := queries[i]
        if k == 0 {
            res[i] = -1
            continue
        }
        dists := make([]int, len(obstacles))
        for j := 0; j < len(obstacles); j++ {
            dx := obstacles[j].x - x[i]
            dy := obstacles[j].y - y[i]
            dists[j] = dx*dx + dy*dy
        }
        sort.Ints(dists)
        if k <= len(dists) {
            res[i] = dists[k-1]
        } else {
            res[i] = -1
        }
    }
    return res
}