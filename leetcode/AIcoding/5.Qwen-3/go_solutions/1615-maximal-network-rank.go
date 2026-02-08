package main

func maxNetworkRank(n int, roads [][]int) int {
    degree := make([]int, n)
    connected := make([][]bool, n)
    for i := range connected {
        connected[i] = make([]bool, n)
    }
    for _, road := range roads {
        a, b := road[0], road[1]
        degree[a]++
        degree[b]++
        connected[a][b] = true
        connected[b][a] = true
    }
    maxRank := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if connected[i][j] {
                currentRank := degree[i] + degree[j]
                if currentRank > maxRank {
                    maxRank = currentRank
                }
            }
        }
    }
    return maxRank
}