func nearestExit(maze [][]byte, entrance []int) int {
    m := len(maze)
    n := len(maze[0])

    startRow, startCol := entrance[0], entrance[1]

    // Queue for BFS: stores {row, col, steps}
    type cell struct {
        r, c, steps int
    }
    queue := []cell{}

    // Visited array to keep track of visited cells
    visited := make([][]bool, m)
    for i := range visited {