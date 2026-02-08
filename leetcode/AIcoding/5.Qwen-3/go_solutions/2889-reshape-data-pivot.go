package main

func pivotTable(table [][]string) [][]string {
    if len(table) == 0 {
        return [][]string{}
    }

    header := table[0]
    rows := table[1:]

    keyMap := make(map[string]map[string]string)
    for _, row := range rows {
        key := row[0]
        col := row[1]
        val := row[2]

        if _, ok := keyMap[key]; !ok {
            keyMap[key] = make(map[string]string)
        }
        keyMap[key][col] = val
    }

    result := [][]string{}
    result = append(result, append([]string{"key"}, header[1:]...))

    for key, cols := range keyMap {
        newRow := []string{key}
        for _, col := range header[1:] {
            newRow = append(newRow, cols[col])
        }
        result = append(result, newRow)
    }

    return result
}