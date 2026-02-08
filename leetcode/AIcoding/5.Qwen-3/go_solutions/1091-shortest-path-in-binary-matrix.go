package main

func shortestPathBinaryMatrix(grid [][]int) int {
    if grid[0][0] != 0 || grid[len(grid)-1][len(grid[0])-1] != 0 {
        return -1
    }

    directions := [][]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    queue := [][]int{{0, 0}}
    grid[0][0] = 1

    for len(queue) > 0 {
        for _, cell := range queue {
            row, col := cell[0], cell[1]
            if row == len(grid)-1 && col == len(grid[0])-1 {
                return grid[row][col]
            }
            for _, dir := range directions {
                newRow, newCol := row+dir[0], col+dir[1]
                if newRow >= 0 && newCol >= 0 && newRow < len(grid) && newCol < len(grid[0]) && grid[newRow][newCol] == 0 {
                    grid[newRow][newCol] = grid[row][col] + 1
                    queue = append(queue, []int{newRow, newCol})
                }
            }
        }
        queue = queue[1:]
    }

    return -1
}