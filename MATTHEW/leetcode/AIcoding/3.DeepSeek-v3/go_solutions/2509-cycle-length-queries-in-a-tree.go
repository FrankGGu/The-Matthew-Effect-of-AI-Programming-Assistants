func cycleLengthQueries(n int, queries [][]int) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        a, b := q[0], q[1]
        length := 1
        for a != b {
            if a > b {
                a /= 2
            } else {
                b /= 2
            }
            length++
        }
        res[i] = length
    }
    return res
}