func maxEqualRowsAfterFlips(matrix [][]int) int {
    count := make(map[string]int)
    for _, row := range matrix {
        key := ""
        first := row[0]
        for _, num := range row {
            if num == first {
                key += "1"
            } else {
                key += "0"
            }
        }
        count[key]++
    }
    max := 0
    for _, v := range count {
        if v > max {
            max = v
        }
    }
    return max
}