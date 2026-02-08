package main

type Position struct {
    row, col int
}

func nearestExit(maze [][]byte, entrance []int) int {
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    queue := []Position{{entrance[0], entrance[1]}}
    visited := make([][]bool, len(maze))
    for i := range visited {
        visited[i] = make([]bool, len(maze[0]))
    }
    visited[entrance[0]][entrance[1]] = true
    steps := 0

    for len(queue) > 0 {
        for _, pos := range queue {
            for _, dir := range directions {
                newRow, newCol := pos.row+dir[0], pos.col+dir[1]
                if newRow >= 0 && newRow < len(maze) && newCol >= 0 && newCol < len(maze[0]) && !visited[newRow][newCol] && maze[newRow][newCol] == '.' {
                    if newRow == 0 || newRow == len(maze)-1 || newCol == 0 || newCol == len(maze[0])-1 {
                        return steps + 1
                    }
                    visited[newRow][newCol] = true
                    queue = append(queue, Position{newRow, newCol})
                }
            }
        }
        queue = queue[1:]
        steps++
    }

    return -1
}