func gardenNoAdj(n int, paths [][]int) []int {
    adj := make([][]int, n)
    for _, path := range paths {
        u, v := path[0]-1, path[1]-1 // Adjust to 0-indexed
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    ans := make([]int, n) // ans[i] will store the flower type for garden i+1

    for i := 0; i < n; i++ {
        // Keep track of colors used by neighbors of current garden i
        usedColors := make([]bool, 5) // Colors are 1-indexed, so size 5 for indices 1-4

        for _, neighbor := range adj[i] {
            // If the neighbor has already been colored, mark its color as used
            if ans[neighbor] != 0 {
                usedColors[ans[neighbor]] = true
            }
        }

        // Find the smallest available color (1, 2,