func numMagicSquaresInside(grid [][]int) int {
    count := 0
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    for i := 0; i <= rows-3; i++ {
        for j := 0; j <= cols-3; j++ {
            if isMagicSquare(grid, i, j) {
                count++
            }
        }
    }
    return count
}

func isMagicSquare(grid [][]int, x, y int) bool {
    nums := make(map[int]bool)
    for i := x; i < x+3; i++ {
        for j := y; j < y+3; j++ {
            num := grid[i][j]
            if num < 1 || num > 9 || nums[num] {
                return false
            }
            nums[num] = true
        }
    }

    sum := grid[x][y] + grid[x][y+1] + grid[x][y+2]

    for i := 1; i < 3; i++ {
        if grid[x+i][y] + grid[x+i][y+1] + grid[x+i][y+2] != sum {
            return false
        }
    }

    for j := 0; j < 3; j++ {
        if grid[x][y+j] + grid[x+1][y+j] + grid[x+2][y+j] != sum {
            return false
        }
    }

    if grid[x][y] + grid[x+1][y+1] + grid[x+2][y+2] != sum {
        return false
    }

    if grid[x][y+2] + grid[x+1][y+1] + grid[x+2][y] != sum {
        return false
    }

    return true
}