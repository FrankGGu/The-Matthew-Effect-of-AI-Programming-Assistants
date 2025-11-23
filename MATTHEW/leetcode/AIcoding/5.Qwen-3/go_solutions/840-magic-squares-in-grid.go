package main

func numMagicSquaresInGrid(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    count := 0
    for i := 0; i < rows-2; i++ {
        for j := 0; j < cols-2; j++ {
            if isMagicSquare(grid, i, j) {
                count++
            }
        }
    }
    return count
}

func isMagicSquare(grid [][]int, x, y int) bool {
    seen := make(map[int]bool)
    sum := 0
    for i := 0; i < 3; i++ {
        for j := 0; j < 3; j++ {
            num := grid[x+i][y+j]
            if num < 1 || num > 9 {
                return false
            }
            if seen[num] {
                return false
            }
            seen[num] = true
            if i == 0 {
                sum += num
            }
        }
    }
    if grid[x][y]+grid[x][y+1]+grid[x][y+2] != sum {
        return false
    }
    if grid[x+1][y]+grid[x+1][y+1]+grid[x+1][y+2] != sum {
        return false
    }
    if grid[x+2][y]+grid[x+2][y+1]+grid[x+2][y+2] != sum {
        return false
    }
    if grid[x][y]+grid[x+1][y]+grid[x+2][y] != sum {
        return false
    }
    if grid[x][y+1]+grid[x+1][y+1]+grid[x+2][y+1] != sum {
        return false
    }
    if grid[x][y+2]+grid[x+1][y+2]+grid[x+2][y+2] != sum {
        return false
    }
    if grid[x][y]+grid[x+1][y+1]+grid[x+2][y+2] != sum {
        return false
    }
    if grid[x][y+2]+grid[x+1][y+1]+grid[x+2][y] != sum {
        return false
    }
    return true
}