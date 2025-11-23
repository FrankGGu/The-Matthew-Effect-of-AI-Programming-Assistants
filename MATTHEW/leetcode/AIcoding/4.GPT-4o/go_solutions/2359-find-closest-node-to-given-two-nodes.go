type ListNode struct {
    Val  int
    Next *ListNode
}

func closestMeetingNode(edges []int, node1 int, node2 int) int {
    n := len(edges)
    dist1 := make([]int, n)
    dist2 := make([]int, n)

    for i := range dist1 {
        dist1[i] = -1
        dist2[i] = -1
    }

    bfs(edges, node1, dist1)
    bfs(edges, node2, dist2)

    closestNode := -1
    minDist := n

    for i := 0; i < n; i++ {
        if dist1[i] != -1 && dist2[i] != -1 {
            maxDist := max(dist1[i], dist2[i])
            if maxDist < minDist {
                minDist = maxDist
                closestNode = i
            } else if maxDist == minDist {
                closestNode = min(closestNode, i)
            }
        }
    }

    return closestNode
}

func bfs(edges []int, start int, dist []int) {
    queue := []int{start}
    dist[start] = 0
    visited := make(map[int]bool)
    visited[start] = true
    idx := 0

    for idx < len(queue) {
        node := queue[idx]
        idx++
        nextNode := edges[node]
        if nextNode != -1 && !visited[nextNode] {
            visited[nextNode] = true
            dist[nextNode] = dist[node] + 1
            queue = append(queue, nextNode)
        }
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}