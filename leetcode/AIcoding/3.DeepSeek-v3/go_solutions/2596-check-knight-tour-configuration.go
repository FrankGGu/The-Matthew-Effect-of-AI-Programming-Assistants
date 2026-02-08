func checkValidGrid(grid [][]int) bool {
    if grid[0][0] != 0 {
        return false
    }
    n := len(grid)
    moves := make([][2]int, n*n)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            pos := grid[i][j]
            moves[pos] = [2]int{i, j}
        }
    }
    for i := 1; i < len(moves); i++ {
        prev := moves[i-1]
        curr := moves[i]
        dx := abs(prev[0] - curr[0])
        dy := abs(prev[1] - curr[1])
        if !((dx == 1 && dy == 2) || (dx == 2 && dy == 1)) {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}