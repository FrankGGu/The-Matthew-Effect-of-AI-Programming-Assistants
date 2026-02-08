func minimumMoves(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    totalStones := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            totalStones += grid[i][j]
        }
    }

    if totalStones == 0 {
        return 0
    }

    target := totalStones / (n * m)
    remainder := totalStones % (n * m)
    moves := 0

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] < target {
                moves += target - grid[i][j]
            }
        }
    }

    return moves + remainder
}