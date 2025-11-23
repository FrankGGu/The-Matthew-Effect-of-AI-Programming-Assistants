func hasValidPath(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    dirs := [][]int{
        {0, -1, 0, 1}, // street 1: left, right
        {-1, 0, 1, 0}, // street 2: up, down
        {0, -1, 1, 0}, // street 3: left, down
        {0, 1, 1, 0},  // street 4: right, down
        {0, -1, -1, 0},// street 5: left, up
        {0, 1, -1, 0}, // street 6: right, up
    }

    queue := [][]int{{0, 0}}
    visited[0][0] = true

    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        x, y := cell[0], cell[1]
        if x == m-1 && y == n-1 {
            return true
        }
        street := grid[x][y] - 1
        for i := 0; i < 2; i++ {
            dx, dy := dirs[street][2*i], dirs[street][2*i+1]
            nx, ny := x+dx, y+dy
            if nx < 0 || nx >= m || ny < 0 || ny >= n || visited[nx][ny] {
                continue
            }
            nextStreet := grid[nx][ny] - 1
            valid := false
            for j := 0; j < 2; j++ {
                ndx, ndy := dirs[nextStreet][2*j], dirs[nextStreet][2*j+1]
                if nx+ndx == x && ny+ndy == y {
                    valid = true
                    break
                }
            }
            if valid {
                visited[nx][ny] = true
                queue = append(queue, []int{nx, ny})
            }
        }
    }
    return false
}