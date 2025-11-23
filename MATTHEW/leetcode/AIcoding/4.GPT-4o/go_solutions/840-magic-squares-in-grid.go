func numMagicSquaresInside(grid [][]int) int {
    count := 0
    for i := 0; i < len(grid)-2; i++ {
        for j := 0; j < len(grid[0])-2; j++ {
            if isMagicSquare(grid, i, j) {
                count++
            }
        }
    }
    return count
}

func isMagicSquare(grid [][]int, row int, col int) bool {
    nums := make(map[int]bool)
    sum := 0
    for i := 0; i < 3; i++ {
        for j := 0; j < 3; j++ {
            num := grid[row+i][col+j]
            if num < 1 || num > 9 || nums[num] {
                return false
            }
            nums[num] = true
            sum += num
        }
    }
    if sum != 15 {
        return false
    }
    return grid[row][col]+grid[row][col+1]+grid[row][col+2] == 15 &&
           grid[row+1][col]+grid[row+1][col+1]+grid[row+1][col+2] == 15 &&
           grid[row+2][col]+grid[row+2][col+1]+grid[row+2][col+2] == 15 &&
           grid[row][col]+grid[row+1][col]+grid[row+2][col] == 15 &&
           grid[row][col+1]+grid[row+1][col+1]+grid[row+2][col+1] == 15 &&
           grid[row][col+2]+grid[row+1][col+2]+grid[row+2][col+2] == 15 &&
           grid[row][col]+grid[row+1][col+1]+grid[row+2][col+2] == 15 &&
           grid[row+2][col]+grid[row+1][col+1]+grid[row][col+2] == 15
}