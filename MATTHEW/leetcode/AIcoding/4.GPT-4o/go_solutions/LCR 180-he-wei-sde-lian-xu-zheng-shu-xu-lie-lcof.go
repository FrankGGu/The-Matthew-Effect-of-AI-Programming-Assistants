func combineFiles(files [][]int) [][]int {
    if len(files) == 0 {
        return nil
    }

    sort.Slice(files, func(i, j int) bool {
        return files[i][0] < files[j][0]
    })

    result := [][]int{}
    current := files[0]

    for i := 1; i < len(files); i++ {
        if files[i][0] <= current[1] {
            current[1] = max(current[1], files[i][1])
        } else {
            result = append(result, current)
            current = files[i]
        }
    }
    result = append(result, current)

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}