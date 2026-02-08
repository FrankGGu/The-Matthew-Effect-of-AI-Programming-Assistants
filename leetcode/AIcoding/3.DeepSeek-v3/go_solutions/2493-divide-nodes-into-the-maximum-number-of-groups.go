func magnificentSets(n int, edges [][]int) int {
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visited := make([]int, n+1)
    groups := make([][]int, 0)

    for i := 1; i <= n; i++ {
        if visited[i] == 0 {
            queue := []int{i}
            visited[i] = 1
            component := []int{i}
            for len(queue) > 0 {
                u := queue[0]
                queue = queue[1:]
                for _, v := range adj[u] {
                    if visited[v] == 0 {
                        visited[v] = visited[u] + 1
                        queue = append(queue, v)
                        component = append(component, v)
                    } else if (visited[v]-visited[u])%2 == 0 {
                        return -1
                    }
                }
            }
            groups = append(groups, component)
        }
    }

    maxGroups := 0
    for _, component := range groups {
        maxDepth := 0
        for _, start := range component {
            depth := make([]int, n+1)
            queue := []int{start}
            depth[start] = 1
            currentMax := 1
            for len(queue) > 0 {
                u := queue[0]
                queue = queue[1:]
                for _, v := range adj[u] {
                    if depth[v] == 0 {
                        depth[v] = depth[u] + 1
                        currentMax = depth[v]
                        queue = append(queue, v)
                    }
                }
            }
            if currentMax > maxDepth {
                maxDepth = currentMax
            }
        }
        maxGroups += maxDepth
    }

    return maxGroups
}