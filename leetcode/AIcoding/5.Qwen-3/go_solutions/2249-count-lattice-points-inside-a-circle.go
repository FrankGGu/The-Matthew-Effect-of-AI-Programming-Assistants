package main

func countLatticePoints(rectangles [][]int, circles [][]int) int {
    points := make(map[[2]int]bool)
    for _, rect := range rectangles {
        x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]
        for x := x1; x <= x2; x++ {
            for y := y1; y <= y2; y++ {
                points[[2]int{x, y}] = true
            }
        }
    }
    for _, circle := range circles {
        cx, cy, r := circle[0], circle[1], circle[2]
        for x := cx - r; x <= cx + r; x++ {
            for y := cy - r; y <= cy + r; y++ {
                if (x-cx)*(x-cx)+(y-cy)*(y-cy) <= r*r {
                    points[[2]int{x, y}] = true
                }
            }
        }
    }
    return len(points)
}