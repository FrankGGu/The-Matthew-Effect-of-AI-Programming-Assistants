func distinctNumbersOnBoard(operations [][]int) int {
    numSet := make(map[int]struct{})
    for _, op := range operations {
        numSet[op[0]] = struct{}{}
        numSet[op[1]] = struct{}{}
    }
    return len(numSet)
}