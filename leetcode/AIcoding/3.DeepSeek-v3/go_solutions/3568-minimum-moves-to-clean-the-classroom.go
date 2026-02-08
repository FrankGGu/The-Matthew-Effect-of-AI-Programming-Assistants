func minimumMoves(grid [][]int) int {
    n := len(grid)
    target := make([]int, n*n)
    for i := 0; i < n*n; i++ {
        target[i] = i + 1
    }
    target[n*n-1] = 0

    start := make([]int, n*n)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            start[i*n+j] = grid[i][j]
        }
    }

    visited := make(map[string]bool)
    queue := [][]int{start}
    steps := 0
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[i]
            if isEqual(current, target) {
                return steps
            }
            zeroPos := findZero(current)
            x, y := zeroPos/n, zeroPos%n
            for _, dir := range dirs {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && nx < n && ny >= 0 && ny < n {
                    next := make([]int, n*n)
                    copy(next, current)
                    next[zeroPos], next[nx*n+ny] = next[nx*n+ny], next[zeroPos]
                    key := getKey(next)
                    if !visited[key] {
                        visited[key] = true
                        queue = append(queue, next)
                    }
                }
            }
        }
        queue = queue[size:]
        steps++
    }
    return -1
}

func isEqual(a, b []int) bool {
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}

func findZero(arr []int) int {
    for i := 0; i < len(arr); i++ {
        if arr[i] == 0 {
            return i
        }
    }
    return -1
}

func getKey(arr []int) string {
    key := ""
    for _, num := range arr {
        key += strconv.Itoa(num) + ","
    }
    return key
}