func leftmostBuildingQueries(heights []int, queries [][]int) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        a, b := q[0], q[1]
        if a > b {
            a, b = b, a
        }
        if a == b || heights[a] < heights[b] {
            res[i] = b
        } else {
            j := b + 1
            for j < len(heights) && heights[j] <= heights[a] {
                j++
            }
            if j < len(heights) {
                res[i] = j
            } else {
                res[i] = -1
            }
        }
    }
    return res
}