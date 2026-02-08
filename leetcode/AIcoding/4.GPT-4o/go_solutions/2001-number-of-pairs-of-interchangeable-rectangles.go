func interchangeableRectangles(rectangles [][]int) int64 {
    ratioCount := make(map[float64]int)
    var result int64 = 0

    for _, rect := range rectangles {
        ratio := float64(rect[0]) / float64(rect[1])
        ratioCount[ratio]++
    }

    for _, count := range ratioCount {
        result += int64(count * (count - 1) / 2)
    }

    return result
}