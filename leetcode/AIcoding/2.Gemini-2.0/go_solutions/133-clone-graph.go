func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }

    visited := make(map[*Node]*Node)
    queue := []*Node{node}
    visited[node] = &Node{Val: node.Val, Neighbors: []*Node{}}

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]

        for _, neighbor := range curr.Neighbors {
            if _, ok := visited[neighbor]; !ok {
                visited[neighbor] = &Node{Val: neighbor.Val, Neighbors: []*Node{}}
                queue = append(queue, neighbor)
            }
            visited[curr].Neighbors = append(visited[curr].Neighbors, visited[neighbor])
        }
    }

    return visited[node]
}