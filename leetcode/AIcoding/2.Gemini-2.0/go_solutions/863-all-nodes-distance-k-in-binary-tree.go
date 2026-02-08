func distanceK(root *TreeNode, target *TreeNode, k int) []int {
    graph := make(map[int][]int)
    var buildGraph func(*TreeNode)
    buildGraph = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Left != nil {
            graph[node.Val] = append(graph[node.Val], node.Left.Val)
            graph[node.Left.Val] = append(graph[node.Left.Val], node.Val)
            buildGraph(node.Left)
        }
        if node.Right != nil {
            graph[node.Val] = append(graph[node.Val], node.Right.Val)
            graph[node.Right.Val] = append(graph[node.Right.Val], node.Val)
            buildGraph(node.Right)
        }
    }
    buildGraph(root)

    visited := make(map[int]bool)
    queue := []int{target.Val}
    visited[target.Val] = true
    dist := 0
    result := []int{}

    for len(queue) > 0 {
        if dist == k {
            for _, node := range queue {
                result = append(result, node)
            }
            return result
        }

        size := len(queue)
        nextQueue := []int{}
        for i := 0; i < size; i++ {
            curr := queue[i]
            for _, neighbor := range graph[curr] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    nextQueue = append(nextQueue, neighbor)
                }
            }
        }
        queue = nextQueue
        dist++
    }

    return result
}