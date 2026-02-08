package main

func minAreaRect(grid [][]int) int {
    points := make(map[int]map[int]bool)
    for i, row := range grid {
        for j, val := range row {
            if val == 1 {
                if _, ok := points[i]; !ok {
                    points[i] = make(map[int]bool)
                }
                points[i][j] = true
            }
        }
    }

    var minArea = float64(1 << 31)
    keys := make([]int, 0, len(points))
    for k := range points {
        keys = append(keys, k)
    }

    for i := 0; i < len(keys); i++ {
        x1 := keys[i]
        for j := i + 1; j < len(keys); j++ {
            x2 := keys[j]
            ySet := make(map[int]bool)
            for y := range points[x1] {
                if points[x2][y] {
                    ySet[y] = true
                }
            }
            if len(ySet) >= 2 {
                yList := make([]int, 0, len(ySet))
                for y := range ySet {
                    yList = append(yList, y)
                }
                sort.Ints(yList)
                for k := 0; k < len(yList)-1; k++ {
                    y1 := yList[k]
                    y2 := yList[k+1]
                    area := (x2 - x1) * (y2 - y1)
                    if area < int(minArea) {
                        minArea = float64(area)
                    }
                }
            }
        }
    }

    if minArea == float64(1<<31) {
        return 0
    }
    return int(minArea)
}