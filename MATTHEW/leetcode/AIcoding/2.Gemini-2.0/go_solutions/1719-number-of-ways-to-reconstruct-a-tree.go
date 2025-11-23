func checkWays(pairs [][]int) int {
    graph := make(map[int]map[int]bool)
    nodes := make(map[int]bool)
    for _, p := range pairs {
        u, v := p[0], p[1]
        if graph[u] == nil {
            graph[u] = make(map[int]bool)
        }
        if graph[v] == nil {
            graph[v] = make(map[int]bool)
        }
        graph[u][v] = true
        graph[v][u] = true
        nodes[u] = true
        nodes[v] = true
    }

    root := -1
    maxDegree := -1
    for node := range nodes {
        degree := len(graph[node])
        if degree > maxDegree {
            maxDegree = degree
            root = node
        }
    }

    if root == -1 {
        return 1
    }

    parent := make(map[int]int)
    for node := range nodes {
        parent[node] = -1
    }

    for neighbor := range graph[root] {
        parent[neighbor] = root
    }

    for node := range nodes {
        if node == root {
            continue
        }
        degree := len(graph[node])
        foundParent := false
        for neighbor := range graph[node] {
            if degree > len(graph[neighbor]) {
                if parent[node] == -1 || parent[node] == neighbor {
                    parent[node] = neighbor
                    foundParent = true
                    break
                }
            }
        }
        if !foundParent {
            minDegree := 100000
            potentialParent := -1
            for neighbor := range graph[node] {
                degree2 := len(graph[neighbor])
                if degree2 < minDegree{
                    minDegree = degree2
                    potentialParent = neighbor
                }
            }
            if potentialParent != -1 {
                parent[node] = potentialParent
                foundParent = true
            }

        }
        if !foundParent {
            return 0
        }
    }

    for node := range nodes {
        if node == root {
            continue
        }
        p := parent[node]
        if !graph[node][p] {
            return 0
        }
    }

    count := 0
    for node := range nodes {
        if node == root {
            continue
        }
        if len(graph[node]) == len(graph[parent[node]]) {
            count++
            break
        }
    }

    adj := make(map[int]map[int]bool)
    for node := range nodes {
        adj[node] = make(map[int]bool)
    }

    for node := range nodes {
        if node == root {
            continue
        }
        adj[node][parent[node]] = true
        adj[parent[node]][node] = true
    }

    visited := make(map[int]bool)
    q := []int{root}
    visited[root] = true
    reachableNodes := 1
    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        for v := range graph[u] {
            if !visited[v] {
                visited[v] = true
                reachableNodes++
                q = append(q, v)
            }
        }
    }

    if reachableNodes != len(nodes) {
        return 0
    }

    if count > 0 {
        return 2
    }
    return 1
}