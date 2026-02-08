package main


func distanceK(root *TreeNode, target *TreeNode, k int) []int {
    var result []int
    parent := make(map[*TreeNode]*TreeNode)
    var dfs func(*TreeNode, *TreeNode)
    dfs = func(node, p *TreeNode) {
        if node == nil {
            return
        }
        parent[node] = p
        dfs(node.Left, node)
        dfs(node.Right, node)
    }
    dfs(root, nil)

    visited := make(map[*TreeNode]bool)
    queue := []*TreeNode{target}
    visited[target] = true

    for k > 0 && len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            if node.Left != nil && !visited[node.Left] {
                visited[node.Left] = true
                queue = append(queue, node.Left)
            }
            if node.Right != nil && !visited[node.Right] {
                visited[node.Right] = true
                queue = append(queue, node.Right)
            }
            if parent[node] != nil && !visited[parent[node]] {
                visited[parent[node]] = true
                queue = append(queue, parent[node])
            }
        }
        k--
    }

    for _, node := range queue {
        result = append(result, node.Val)
    }
    return result
}