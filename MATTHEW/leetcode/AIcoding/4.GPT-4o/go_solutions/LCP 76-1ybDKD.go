func magicSquare(n int) int {
    if n == 1 {
        return 0
    }
    if n%2 == 1 {
        return 1
    }
    if n%4 == 0 {
        return 0
    }
    return 2
}

func numMagicSquaresInside(grid [][]int) int {
    count := 0
    for i := 0; i < len(grid)-2; i++ {
        for j := 0; j < len(grid[0])-2; j++ {
            if isMagicSquare(grid[i][j:j+3], grid[i+1][j:j+3], grid[i+2][j:j+3]) {
                count++
            }
        }
    }
    return count
}

func isMagicSquare(rows ...[]int) bool {
    nums := make(map[int]int)
    total := 0
    for _, row := range rows {
        for _, num := range row {
            if num < 1 || num > 9 || nums[num] > 0 {
                return false
            }
            nums[num]++
            total += num
        }
    }
    return total == 45 && (rows[0][0]+rows[0][1]+rows[0][2] == 15) &&
        (rows[1][0]+rows[1][1]+rows[1][2] == 15) &&
        (rows[2][0]+rows[2][1]+rows[2][2] == 15) &&
        (rows[0][0]+rows[1][0]+rows[2][0] == 15) &&
        (rows[0][1]+rows[1][1]+rows[2][1] == 15) &&
        (rows[0][2]+rows[1][2]+rows[2][2] == 15) &&
        (rows[0][0]+rows[1][1]+rows[2][2] == 15) &&
        (rows[0][2]+rows[1][1]+rows[2][0] == 15)
}