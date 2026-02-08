type Node struct {
    Val      int
    Adjacent []*Node
}

func propertiesGraph(n int, edges [][]int) bool {
    if n == 0 {
        return false
    }

    graph := make([]*Node, n)
    for i := 0; i < n; i++ {
        graph[i] = &Node{Val: i}
    }

    for _, edge := range edges {
        graph[edge[0]].Adjacent = append(graph[edge[0]].Adjacent, graph[edge[1]])
        graph[edge[1]].Adjacent = append(graph[edge[1]].Adjacent, graph[edge[0]])
    }

    visited := make([]bool, n)
    var isCyclic func(node *Node, parent int) bool
    isCyclic = func(node *Node, parent int) bool {
        visited[node.Val] = true
        for _, neighbor := range node.Adjacent {
            if !visited[neighbor.Val] {
                if isCyclic(neighbor, node.Val) {
                    return true
                }
            } else if neighbor.Val != parent {
                return true
            }
        }
        return false
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            if isCyclic(graph[i], -1) {
                return false
            }
        }
    }

    return true
}