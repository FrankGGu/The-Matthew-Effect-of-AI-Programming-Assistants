package main

func minTotalPrice(n int, roads [][]int, trips [][]int, fee []int) int {
    graph := make([][]int, n)
    for _, road := range roads {
        u, v := road[0], road[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    count := make([]int, n)
    var dfs func(node, parent int) bool
    dfs = func(node, parent int) bool {
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            if dfs(neighbor, node) {
                count[node] += count[neighbor]
            }
        }
        return true
    }

    for _, trip := range trips {
        start, end := trip[0], trip[1]
        visited := make([]bool, n)
        var path []int
        var findPath func(node int) bool
        findPath = func(node int) bool {
            visited[node] = true
            path = append(path, node)
            if node == end {
                return true
            }
            for _, neighbor := range graph[node] {
                if !visited[neighbor] && findPath(neighbor) {
                    return true
                }
            }
            path = path[:len(path)-1]
            return false
        }
        findPath(start)
        for _, node := range path {
            count[node]++
        }
    }

    res := 0
    var dfs2 func(node, parent int) int
    dfs2 = func(node, parent int) int {
        total := fee[node]
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            total += dfs2(neighbor, node)
        }
        return total
    }

    var dfs3 func(node, parent int) int
    dfs3 = func(node, parent int) int {
        total := count[node] * fee[node]
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            total += dfs3(neighbor, node)
        }
        return total
    }

    max := 0
    var dfs4 func(node, parent int) int
    dfs4 = func(node, parent int) int {
        total := 0
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            total += dfs4(neighbor, node)
        }
        return total
    }

    for i := 0; i < n; i++ {
        if count[i] > 0 {
            max = max + count[i]*fee[i]
        }
    }

    return max - dfs4(0, -1)
}