func minimumEffortPath(heights [][]int) int {
    rows, cols := len(heights), len(heights[0])
    directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    left, right := 0, 1_000_000

    for left < right {
        mid := left + (right-left)/2
        if bfs(heights, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func bfs(heights [][]int, limit int) bool {
    rows, cols := len(heights), len(heights[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }
    queue := [][]int{{0, 0}}
    visited[0][0] = true

    for len(queue) > 0 {
        nextQueue := [][]int{}
        for _, pos := range queue {
            if pos[0] == rows-1 && pos[1] == cols-1 {
                return true
            }
            for _, dir := range [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
                r, c := pos[0]+dir[0], pos[1]+dir[1]
                if r >= 0 && r < rows && c >= 0 && c < cols && !visited[r][c] && abs(heights[pos[0]][pos[1]]-heights[r][c]) <= limit {
                    visited[r][c] = true
                    nextQueue = append(nextQueue, []int{r, c})
                }
            }
        }
        queue = nextQueue
    }
    return false
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}