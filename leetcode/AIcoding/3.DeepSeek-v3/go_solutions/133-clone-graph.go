/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Neighbors []*Node
 * }
 */

func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }

    visited := make(map[*Node]*Node)
    queue := []*Node{node}
    visited[node] = &Node{Val: node.Val, Neighbors: []*Node{}}

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        for _, neighbor := range current.Neighbors {
            if _, exists := visited[neighbor]; !exists {
                visited[neighbor] = &Node{Val: neighbor.Val, Neighbors: []*Node{}}
                queue = append(queue, neighbor)
            }
            visited[current].Neighbors = append(visited[current].Neighbors, visited[neighbor])
        }
    }

    return visited[node]
}