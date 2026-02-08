func colorTheArray(n int, queries [][]int) []int {
    nums := make([]int, n)
    res := make([]int, len(queries))
    count := 0

    for i, query := range queries {
        idx, color := query[0], query[1]
        oldColor := nums[idx]

        if oldColor == color {
            res[i] = count
            continue
        }

        if idx > 0 {
            if nums[idx-1] == oldColor && oldColor != 0 {
                count--
            }
            if nums[idx-1] == color {
                count++
            }
        }

        if idx < n-1 {
            if nums[idx+1] == oldColor && oldColor != 0 {
                count--
            }
            if nums[idx+1] == color {
                count++
            }
        }

        nums[idx] = color
        res[i] = count
    }

    return res
}