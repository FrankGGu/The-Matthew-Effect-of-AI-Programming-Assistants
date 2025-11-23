func findFarmland(land [][]int) [][]int {
    rows := len(land)
    if rows == 0 {
        return [][]int{}
    }
    cols := len(land[0])
    if cols == 0 {
        return [][]int{}
    }

    var result [][]int

    for r