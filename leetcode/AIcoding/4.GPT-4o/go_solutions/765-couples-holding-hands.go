func minSwapsCouples(row []int) int {
    n := len(row) / 2
    pos := make([]int, n)
    for i, v := range row {
        pos[v/2] = i
    }

    swaps := 0
    for i := 0; i < len(row); i += 2 {
        partner := row[i] ^ 1
        if row[i+1] != partner {
            swaps++
            swapIndex := pos[partner]
            row[i+1], row[swapIndex] = row[swapIndex], row[i+1]
            pos[row[swapIndex]/2] = swapIndex
            pos[row[i+1]/2] = i + 1
        }
    }

    return swaps
}