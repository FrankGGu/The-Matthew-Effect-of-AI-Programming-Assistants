package main

func findMinHeightTrees(n int, edges [][]int) []int {
    if n == 1 {
        return []int{0}
    }

    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    leaves := make([]int, 0)
    for i := 0; i < n; i++ {
        if len(adj[i]) == 1 {
            leaves = append(leaves, i)
        }
    }

    for n > 2 {
        size := len(leaves)
        n -= size
        for i := 0; i < size; i++ {
            leaf := leaves[i]
            for _, neighbor := range adj[leaf] {
                for j, v := range adj[neighbor] {
                    if v == leaf {
                        adj[neighbor] = append(adj[neighbor][:j], adj[neighbor][j+1:]...)
                        if len(adj[neighbor]) == 1 {
                            leaves = append(leaves, neighbor)
                        }
                        break
                    }
                }
            }
        }
    }

    return leaves
}