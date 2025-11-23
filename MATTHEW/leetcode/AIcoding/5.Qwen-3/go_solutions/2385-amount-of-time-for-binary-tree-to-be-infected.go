package main


func amountOfTime(root *TreeNode, start int) int {
    graph := make(map[int][]int)
    buildGraph(root, nil, graph)

    visited := make(map[int]bool)
    queue := []int{start}
    visited[start] = true

    time := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            for _, neighbor := range graph[node] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    queue = append(queue, neighbor)
                }
            }
        }
        if len(queue) > 0 {
            time++
        }
    }

    return time
}

func buildGraph(node *TreeNode, parent *TreeNode, graph map[int][]int) {
    if node == nil {
        return
    }
    if parent != nil {
        graph[node.Val] = append(graph[node.Val], parent.Val)
        graph[parent.Val] = append(graph[parent.Val], node.Val)
    }
    buildGraph(node.Left, node, graph)
    buildGraph(node.Right, node, graph)
}