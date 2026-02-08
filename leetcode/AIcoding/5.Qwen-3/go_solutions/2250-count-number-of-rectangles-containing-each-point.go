package main

func countRectangles(rectangles [][]int, points [][]int) []int {
    mp := make(map[int][]int)
    for _, rect := range rectangles {
        x1, y1 := rect[0], rect[1]
        x2, y2 := rect[2], rect[3]
        if x1 > x2 {
            x1, x2 = x2, x1
        }
        if y1 > y2 {
            y1, y2 = y2, y1
        }
        mp[y1] = append(mp[y1], x1)
        mp[y2] = append(mp[y2], x2)
    }
    for k := range mp {
        sort.Ints(mp[k])
    }
    res := make([]int, len(points))
    for i, p := range points {
        x, y := p[0], p[1]
        cnt := 0
        for h := y; h <= 1000; h++ {
            if ys, ok := mp[h]; ok {
                idx := sort.SearchInts(ys, x)
                cnt += len(ys) - idx
            }
        }
        res[i] = cnt
    }
    return res
}