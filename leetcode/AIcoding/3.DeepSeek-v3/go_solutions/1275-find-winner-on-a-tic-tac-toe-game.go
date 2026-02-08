func tictactoe(moves [][]int) string {
    grid := make([][]int, 3)
    for i := range grid {
        grid[i] = make([]int, 3)
    }

    for i, move := range moves {
        player := 1
        if i % 2 == 1 {
            player = 2
        }
        grid[move[0]][move[1]] = player
    }

    for i := 0; i < 3; i++ {
        if grid[i][0] != 0 && grid[i][0] == grid[i][1] && grid[i][1] == grid[i][2] {
            if grid[i][0] == 1 {
                return "A"
            } else {
                return "B"
            }
        }
        if grid[0][i] != 0 && grid[0][i] == grid[1][i] && grid[1][i] == grid[2][i] {
            if grid[0][i] == 1 {
                return "A"
            } else {
                return "B"
            }
        }
    }

    if grid[0][0] != 0 && grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2] {
        if grid[0][0] == 1 {
            return "A"
        } else {
            return "B"
        }
    }
    if grid[0][2] != 0 && grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0] {
        if grid[0][2] == 1 {
            return "A"
        } else {
            return "B"
        }
    }

    if len(moves) == 9 {
        return "Draw"
    } else {
        return "Pending"
    }
}