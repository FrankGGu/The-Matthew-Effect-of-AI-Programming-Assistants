func createNewColumn(table [][]int) [][]int {
    for i := range table {
        table[i] = append(table[i], table[i][0]+table[i][1])
    }
    return table
}