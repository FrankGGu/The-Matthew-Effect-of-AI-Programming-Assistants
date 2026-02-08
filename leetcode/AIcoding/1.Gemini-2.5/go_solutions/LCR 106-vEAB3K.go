func isBipartite(graph [][]int) bool {
    n := len(graph)
    // colors: -1 uncolored, 0 color A, 1 color B
    colors := make([]int, n)
    for i := range colors {
        colors[i] = -1 // Initialize all nodes as uncolored