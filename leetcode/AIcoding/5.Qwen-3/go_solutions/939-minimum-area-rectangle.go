package main

func minAreaRect(rectangles [][]int) int {
    points := make(map[int]bool)
    for _, rect := range rectangles {
        x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]
        for x := x1; x <= x2; x++ {
            for y := y1; y <= y2; y++ {
                points[x*100000+y] = true
            }
        }
    }

    var minArea int = math.MaxInt32
    keys := make([]int, 0, len(points))
    for k := range points {
        keys = append(keys, k)
    }

    for i := 0; i < len(keys); i++ {
        for j := i + 1; j < len(keys); j++ {
            key1 := keys[i]
            key2 := keys[j]
            x1 := key1 / 100000
            y1 := key1 % 100000
            x2 := key2 / 100000
            y2 := key2 % 100000
            if (x1 == x2 || y1 == y2) {
                continue
            }
            if points[x1*100000+y2] && points[x2*100000+y1] {
                area := abs(x1-x2) * abs(y1-y2)
                if area < minArea {
                    minArea = area
                }
            }
        }
    }

    if minArea == math.MaxInt32 {
        return 0
    }
    return minArea
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}