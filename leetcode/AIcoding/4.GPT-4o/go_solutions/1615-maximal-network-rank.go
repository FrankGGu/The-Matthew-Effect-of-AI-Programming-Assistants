func maximalNetworkRank(n int, roads [][]int) int {
    degree := make([]int, n)
    roadSet := make(map[[2]int]struct{})

    for _, road := range roads {
        degree[road[0]]++
        degree[road[1]]++
        if road[0] < road[1] {
            roadSet[[2]int{road[0], road[1]}] = struct{}{}
        } else {
            roadSet[[2]int{road[1], road[0]}] = struct{}{}
        }
    }

    maxRank := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            rank := degree[i] + degree[j]
            if _, exists := roadSet[[2]int{i, j}]; exists {
                rank--
            }
            if rank > maxRank {
                maxRank = rank
            }
        }
    }

    return maxRank
}