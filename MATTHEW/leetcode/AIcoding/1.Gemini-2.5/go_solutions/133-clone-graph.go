func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }

    visited := make(map[*Node]*Node)

    var dfs func(*Node) *Node
    dfs = func(originalNode *Node) *Node {
        if clonedNode, ok := visited[originalNode]; ok {
            return clonedNode
        }

        clonedNode := &Node{Val: originalNode.Val}
        visited[originalNode] = clonedNode

        for _, neighbor := range originalNode.Neighbors {
            clonedNode.Neighbors = append(clonedNode.Neighbors, dfs(neighbor))
        }

        return clonedNode
    }

    return dfs(node)
}