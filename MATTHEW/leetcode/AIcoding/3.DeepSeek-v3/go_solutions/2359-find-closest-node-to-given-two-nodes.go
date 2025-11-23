func closestMeetingNode(edges []int, node1 int, node2 int) int {
    n := len(edges)
    dist1 := make([]int, n)
    dist2 := make([]int, n)
    for i := range dist1 {
        dist1[i] = -1
        dist2[i] = -1
    }
    dist1[node1] = 0
    dist2[node2] = 0

    var dfs func(int, []int)
    dfs = func(node int, dist []int) {
        next := edges[node]
        if next != -1 && dist[next] == -1 {
            dist[next] = dist[node] + 1
            dfs(next, dist)
        }
    }
    dfs(node1, dist1)
    dfs(node2, dist2)

    minDist := math.MaxInt32
    result := -1
    for i := 0; i < n; i++ {
        if dist1[i] != -1 && dist2[i] != -1 {
            maxDist := max(dist1[i], dist2[i])
            if maxDist < minDist {
                minDist = maxDist
                result = i
            } else if maxDist == minDist && i < result {
                result = i
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}