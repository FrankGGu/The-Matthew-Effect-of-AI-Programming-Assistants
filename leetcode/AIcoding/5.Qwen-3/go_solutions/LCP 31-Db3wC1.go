package main

func findShortestPath(maze [][]int, start []int, destination []int) int {
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    m, n := len(maze), len(maze[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := [][]int{start}
    visited[start[0]][start[1]] = true
    steps := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            pos := queue[0]
            queue = queue[1:]
            if pos[0] == destination[0] && pos[1] == destination[1] {
                return steps
            }
            for _, dir := range dirs {
                x, y := pos[0], pos[1]
                for x >= 0 && x < m && y >= 0 && y < n && maze[x][y] == 0 {
                    x += dir[0]
                    y += dir[1]
                }
                x -= dir[0]
                y -= dir[1]
                if !visited[x][y] {
                    visited[x][y] = true
                    queue = append(queue, []int{x, y})
                }
            }
        }
        steps++
    }
    return -1
}