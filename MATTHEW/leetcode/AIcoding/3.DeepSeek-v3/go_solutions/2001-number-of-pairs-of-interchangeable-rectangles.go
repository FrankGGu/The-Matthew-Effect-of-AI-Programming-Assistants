func interchangeableRectangles(rectangles [][]int) int64 {
    ratioCount := make(map[float64]int64)
    var res int64

    for _, rect := range rectangles {
        w, h := rect[0], rect[1]
        ratio := float64(w) / float64(h)
        res += ratioCount[ratio]
        ratioCount[ratio]++
    }

    return res
}