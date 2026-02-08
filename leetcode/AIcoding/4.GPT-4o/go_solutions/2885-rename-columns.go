func renameColumns(columns [][]string, names []string) [][]string {
    for i, name := range names {
        columns[0][i] = name
    }
    return columns
}