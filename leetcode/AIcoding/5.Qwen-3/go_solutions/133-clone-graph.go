package main

type Node struct {
    Val       int
    Neighbors []*Node
}

func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }
    visited := make(map[int]*Node)
    return dfs(node, visited)
}

func dfs(node *Node, visited map[int]*Node) *Node {
    if cloned, ok := visited[node.Val]; ok {
        return cloned
    }
    cloned := &Node{Val: node.Val}
    visited[node.Val] = cloned
    for _, neighbor := range node.Neighbors {
        cloned.Neighbors = append(cloned.Neighbors, dfs(neighbor, visited))
    }
    return cloned
}