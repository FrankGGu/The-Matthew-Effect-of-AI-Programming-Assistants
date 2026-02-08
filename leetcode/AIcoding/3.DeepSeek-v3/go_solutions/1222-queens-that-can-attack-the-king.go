func queensAttacktheKing(queens [][]int, king []int) [][]int {
    board := make([][]bool, 8)
    for i := range board {
        board[i] = make([]bool, 8)
    }
    for _, queen := range queens {
        board[queen[0]][queen[1]] = true
    }

    directions := [][]int{
        {-1, -1}, {-1, 0}, {-1, 1},
        {0, -1},          {0, 1},
        {1, -1},  {1, 0}, {1, 1},
    }

    var res [][]int

    for _, dir := range directions {
        x, y := king[0], king[1]
        for {
            x += dir[0]
            y += dir[1]
            if x < 0 || x >= 8 || y < 0 || y >= 8 {
                break
            }
            if board[x][y] {
                res = append(res, []int{x, y})
                break
            }
        }
    }

    return res
}