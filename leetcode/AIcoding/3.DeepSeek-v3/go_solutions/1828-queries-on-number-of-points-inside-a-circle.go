func countPoints(points [][]int, queries [][]int) []int {
    result := make([]int, len(queries))
    for i, query := range queries {
        x, y, r := query[0], query[1], query[2]
        count := 0
        for _, point := range points {
            px, py := point[0], point[1]
            dx := px - x
            dy := py - y
            if dx*dx + dy*dy <= r*r {
                count++
            }
        }
        result[i] = count
    }
    return result
}