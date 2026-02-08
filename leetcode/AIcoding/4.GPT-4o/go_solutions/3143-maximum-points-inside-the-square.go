func countPoints(points [][]int, queries [][]int) []int {
    result := make([]int, len(queries))

    for i, query := range queries {
        x, y, r := query[0], query[1], query[2]
        count := 0
        for _, point := range points {
            if (point[0]-x)*(point[0]-x)+(point[1]-y)*(point[1]-y) <= r*r {
                count++
            }
        }
        result[i] = count
    }

    return result
}