func maxStarSum(vals []int, edges [][]int, k int) int {
    n := len(vals)
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    maxSum := 0
    for i := 0; i < n; i++ {
        if vals[i] > 0 {
            maxSum += vals[i]
        }

        neighbors := []int{}
        for _, neighbor := range graph[i] {
            if vals[neighbor] > 0 {
                neighbors = append(neighbors, vals[neighbor])
            }
        }

        sort.Sort(sort.Reverse(sort.IntSlice(neighbors)))
        currentSum := vals[i]
        for j := 0; j < min(k, len(neighbors)); j++ {
            currentSum += neighbors[j]
        }

        maxSum = max(maxSum, currentSum)
    }

    return maxSum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}