type Cell struct {
    x, y int
}

func maximumMinutes(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    fireSpread := make([][]int, m)
    for i := range fireSpread {
        fireSpread[i] = make([]int, n)
        for j := range fireSpread[i] {
            fireSpread[i][j] = -1
        }
    }

    queue := []Cell{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                fireSpread[i][j] = 0
                queue = append(queue, Cell{i, j})
            }
        }
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        for _, d := range dirs {
            x, y := curr.x+d[0], curr.y+d[1]
            if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 0 && fireSpread[x][y] == -1 {
                fireSpread[x][y] = fireSpread[curr.x][curr.y] + 1
                queue = append(queue, Cell{x, y})
            }
        }
    }

    left, right := 0, m*n
    best := -1
    for left <= right {
        mid := left + (right-left)/2
        if canReach(grid, fireSpread, mid) {
            best = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return best
}

func canReach(grid, fireSpread [][]int, waitTime int) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    queue := []Cell{{0, 0}}
    visited[0][0] = true
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    time := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[i]
            if curr.x == m-1 && curr.y == n-1 {
                return true
            }
            for _, d := range dirs {
                x, y := curr.x+d[0], curr.y+d[1]
                if x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] && grid[x][y] == 0 {
                    if fireSpread[x][y] == -1 || (time+1+waitTime) < fireSpread[x][y] || (x == m-1 && y == n-1 && (time+1+waitTime) <= fireSpread[x][y]) {
                        visited[x][y] = true
                        queue = append(queue, Cell{x, y})
                    }
                }
            }
        }
        queue = queue[size:]
        time++
    }
    return false
}