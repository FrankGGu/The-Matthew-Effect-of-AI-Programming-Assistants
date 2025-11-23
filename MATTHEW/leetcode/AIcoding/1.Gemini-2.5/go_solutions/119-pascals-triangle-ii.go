func getRow(rowIndex int) []int {
    row := make([]int, rowIndex+1)
    row[0] = 1

    for i := 1; i <= rowIndex; i++ {
        // The last element of the current row is always 1
        row[i] = 1
        // Calculate elements from right to left to use values from the previous iteration
        // (which effectively represents the previous row)
        for j := i - 1; j >= 1; j-- {
            row[j] = row[j] + row[j-1]
        }
    }

    return row
}