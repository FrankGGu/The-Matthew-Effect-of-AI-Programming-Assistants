func isEscapePossible(blocked [][]int, source []int, target []int) bool {
    blockedSet := make(map[[2]int]bool)
    for _, b := range blocked {
        blockedSet[[2]int{b[0], b[1]}] = true
    }
    return bfs(blockedSet, source, target) && bfs(blockedSet, target, source)
}

func bfs(blockedSet map[[2]int]bool, source []int, target []int) bool {
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    visited := make(map[[2]int]bool)
    queue := [][2]int{{source[0], source[1]}}
    visited[[2]int{source[0], source[1]}] = true
    steps := 0
    maxSteps := 20000

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[0]
            queue = queue[1:]
            if curr[0] == target[0] && curr[1] == target[1] {
                return true
            }
            for _, dir := range dirs {
                x := curr[0] + dir[0]
                y := curr[1] + dir[1]
                if x >= 0 && x < 1e6 && y >= 0 && y < 1e6 {
                    key := [2]int{x, y}
                    if !blockedSet[key] && !visited[key] {
                        visited[key] = true
                        queue = append(queue, key)
                    }
                }
            }
        }
        steps += size
        if steps >= maxSteps {
            return true
        }
    }
    return false
}