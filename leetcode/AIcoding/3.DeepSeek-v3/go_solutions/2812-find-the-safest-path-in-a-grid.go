type Pair struct {
    x, y int
}

func maximumSafenessFactor(grid [][]int) int {
    n := len(grid)
    if grid[0][0] == 1 || grid[n-1][n-1] == 1 {
        return 0
    }

    queue := make([]Pair, 0)
    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = -1
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                dist[i][j] = 0
                queue = append(queue, Pair{i, j})
            }
        }
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        for _, d := range dirs {
            x, y := curr.x+d[0], curr.y+d[1]
            if x >= 0 && x < n && y >= 0 && y < n && dist[x][y] == -1 {
                dist[x][y] = dist[curr.x][curr.y] + 1
                queue = append(queue, Pair{x, y})
            }
        }
    }

    left, right := 0, n*2
    res := 0
    for left <= right {
        mid := (left + right) / 2
        if canReach(dist, mid) {
            res = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return res
}

func canReach(dist [][]int, minDist int) bool {
    n := len(dist)
    if dist[0][0] < minDist || dist[n-1][n-1] < minDist {
        return false
    }

    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := []Pair{{0, 0}}
    visited[0][0] = true
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        if curr.x == n-1 && curr.y == n-1 {
            return true
        }
        for _, d := range dirs {
            x, y := curr.x+d[0], curr.y+d[1]
            if x >= 0 && x < n && y >= 0 && y < n && !visited[x][y] && dist[x][y] >= minDist {
                visited[x][y] = true
                queue = append(queue, Pair{x, y})
            }
        }
    }
    return false
}