func maxStarSum(vals []int, edges [][]int, k int) int {
    n := len(vals)
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    maxSum := -1 << 31
    for u := 0; u < n; u++ {
        neighbors := make([]int, 0)
        for _, v := range graph[u] {
            neighbors = append(neighbors, vals[v])
        }
        sort.Sort(sort.Reverse(sort.IntSlice(neighbors)))
        sum := vals[u]
        for i := 0; i < k && i < len(neighbors); i++ {
            if neighbors[i] > 0 {
                sum += neighbors[i]
            } else {
                break
            }
        }
        if sum > maxSum {
            maxSum = sum
        }
    }
    return maxSum
}