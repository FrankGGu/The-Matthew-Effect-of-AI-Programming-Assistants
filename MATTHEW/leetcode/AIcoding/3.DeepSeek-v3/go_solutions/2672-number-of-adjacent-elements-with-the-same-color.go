func colorTheArray(n int, queries [][]int) []int {
    colors := make([]int, n)
    res := make([]int, len(queries))
    count := 0

    for i, query := range queries {
        index, color := query[0], query[1]
        if colors[index] == color {
            res[i] = count
            continue
        }

        if index > 0 {
            if colors[index] != 0 && colors[index] == colors[index-1] {
                count--
            }
            if color != 0 && color == colors[index-1] {
                count++
            }
        }

        if index < n-1 {
            if colors[index] != 0 && colors[index] == colors[index+1] {
                count--
            }
            if color != 0 && color == colors[index+1] {
                count++
            }
        }

        colors[index] = color
        res[i] = count
    }

    return res
}