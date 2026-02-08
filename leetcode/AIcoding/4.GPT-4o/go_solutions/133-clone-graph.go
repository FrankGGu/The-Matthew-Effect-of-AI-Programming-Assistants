type Node struct {
    Val       int
    Neighbors []*Node
}

func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }
    cloneMap := make(map[int]*Node)
    var dfs func(n *Node) *Node
    dfs = func(n *Node) *Node {
        if _, ok := cloneMap[n.Val]; ok {
            return cloneMap[n.Val]
        }
        cloneNode := &Node{Val: n.Val}
        cloneMap[n.Val] = cloneNode
        for _, neighbor := range n.Neighbors {
            cloneNode.Neighbors = append(cloneNode.Neighbors, dfs(neighbor))
        }
        return cloneNode
    }
    return dfs(node)
}