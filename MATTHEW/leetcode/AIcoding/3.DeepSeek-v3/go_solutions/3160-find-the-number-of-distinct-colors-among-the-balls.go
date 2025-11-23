func queryResults(limit int, queries [][]int) []int {
    colorMap := make(map[int]int)
    freq := make(map[int]int)
    res := make([]int, len(queries))
    distinct := 0

    for i, query := range queries {
        ball, newColor := query[0], query[1]
        if oldColor, exists := colorMap[ball]; exists {
            freq[oldColor]--
            if freq[oldColor] == 0 {
                distinct--
            }
        }
        colorMap[ball] = newColor
        freq[newColor]++
        if freq[newColor] == 1 {
            distinct++
        }
        res[i] = distinct
    }
    return res
}