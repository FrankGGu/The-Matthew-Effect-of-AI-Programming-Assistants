func areSimilar(mat [][]int, k int) bool {
    rows := len(mat)
    cols := len(mat[0])

    if cols == 0 {
        return true // An empty row is always similar to itself
    }

    effectiveK := k % cols

    if effectiveK == 0 {