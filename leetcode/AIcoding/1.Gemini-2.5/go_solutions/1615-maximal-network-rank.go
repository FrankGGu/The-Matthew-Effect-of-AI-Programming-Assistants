func maximalNetworkRank(n int, roads [][]int) int {
    degree := make([]int, n)
    connected := make([][]bool, n)
    for i := 0; i < n; i++ {
        connected[i] = make([]bool, n)
    }

    for _, road := range roads {
        u, v := road[0], road[1]
        degree[u]++
        degree[v]++
        connected[u][v] = true
        connected[v][u] = true
    }

    maxRank := 0

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            currentRank := degree[i] + degree[j]
            if connected[i][j] {
                currentRank--
            }
            if currentRank > maxRank {
                maxRank = currentRank
            }
        }
    }

    return maxRank
}