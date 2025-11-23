func countRectangles(rectangles [][]int, points [][]int) []int {
    cnt := make([]int, len(points))
    for _, point := range points {
        x, y := point[0], point[1]
        for _, rect := range rectangles {
            if x < rect[0] || y < rect[1] {
                continue
            }
            cnt[i]++
        }
    }
    return cnt
}