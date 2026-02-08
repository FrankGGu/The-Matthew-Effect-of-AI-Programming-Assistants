func countVisitedNodes(edges []int) []int {
    n := len(edges)
    res := make([]int, n)
    visited := make([]bool, n)

    for i := 0; i < n; i++ {
        if !visited[i] {
            path := make([]int, 0)
            current := i
            for {
                if visited[current] {
                    idx := -1
                    for j, node := range path {
                        if node == current {
                            idx = j
                            break
                        }
                    }
                    if idx != -1 {
                        cycleLen := len(path) - idx
                        for j := idx; j < len(path); j++ {
                            res[path[j]] = cycleLen
                        }
                    }
                    for j := 0; j < len(path); j++ {
                        if res[path[j]] == 0 {
                            res[path[j]] = len(path) - j
                        }
                    }
                    break
                }
                visited[current] = true
                path = append(path, current)
                current = edges[current]
            }
        }
    }
    return res
}