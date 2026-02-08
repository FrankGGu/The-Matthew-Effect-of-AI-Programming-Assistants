func maximumInvitations(favorite []int) int {
    n := len(favorite)
    visited := make([]bool, n)
    maxCycle := 0
    sumPairs := 0

    for i := 0; i < n; i++ {
        if !visited[i] {
            cycle := make([]int, 0)
            j := i
            for !visited[j] {
                visited[j] = true
                cycle = append(cycle, j)
                j = favorite[j]
            }
            pos := -1
            for k, v := range cycle {
                if v == j {
                    pos = k
                    break
                }
            }
            if pos != -1 {
                cycleLen := len(cycle) - pos
                if cycleLen > 2 {
                    if cycleLen > maxCycle {
                        maxCycle = cycleLen
                    }
                } else {
                    sumPairs += 2
                    u := cycle[pos]
                    v := cycle[pos+1]
                    maxChain := dfs(u, v, favorite) + dfs(v, u, favorite)
                    sumPairs += maxChain - 2
                }
            }
        }
    }

    if maxCycle > sumPairs {
        return maxCycle
    }
    return sumPairs
}

func dfs(u, v int, favorite []int) int {
    maxDepth := 0
    for i := 0; i < len(favorite); i++ {
        if favorite[i] == u && i != v {
            depth := dfs(i, u, favorite) + 1
            if depth > maxDepth {
                maxDepth = depth
            }
        }
    }
    return maxDepth
}