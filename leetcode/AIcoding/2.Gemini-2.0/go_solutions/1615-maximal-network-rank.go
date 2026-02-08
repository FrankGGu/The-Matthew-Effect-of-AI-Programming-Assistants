func maximalNetworkRank(n int, roads [][]int) int {
    adj := make([][]bool, n)
    for i := 0; i < n; i++ {
        adj[i] = make([]bool, n)
    }
    degrees := make([]int, n)
    for _, road := range roads {
        u, v := road[0], road[1]
        adj[u][v] = true
        adj[v][u] = true
        degrees[u]++
        degrees[v]++
    }
    maxRank := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            rank := degrees[i] + degrees[j]
            if adj[i][j] {
                rank--
            }
            if rank > maxRank {
                maxRank = rank
            }
        }
    }
    return maxRank
}