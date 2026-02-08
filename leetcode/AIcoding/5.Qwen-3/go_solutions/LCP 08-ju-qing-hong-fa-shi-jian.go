package main

func findTriggerTime(vehicles [][]int) []int {
    n := len(vehicles)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        x1, y1 := vehicles[i][0], vehicles[i][1]
        for j := 0; j < n; j++ {
            x2, y2 := vehicles[j][0], vehicles[j][1]
            if i == j {
                continue
            }
            dx := x2 - x1
            dy := y2 - y1
            if dx == 0 && dy == 0 {
                continue
            }
            t := 0
            if dx != 0 {
                t = (x2 - x1) / dx
            } else {
                t = (y2 - y1) / dy
            }
            if t < 0 {
                t = 0
            }
            if dx != 0 && (x2 - x1)%(dx) != 0 {
                t++
            }
            if dy != 0 && (y2 - y1)%(dy) != 0 {
                t++
            }
            res[i] = t
        }
    }
    return res
}