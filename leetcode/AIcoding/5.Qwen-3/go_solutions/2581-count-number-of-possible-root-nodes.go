package main


func possibleRootNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }

    count := 0
    visited := make(map[*TreeNode]bool)
    var dfs func(node *TreeNode, parent *TreeNode)
    dfs = func(node *TreeNode, parent *TreeNode) {
        if node == nil {
            return
        }
        visited[node] = true
        if parent != nil {
            visited[parent] = true
        }
        if node.Left == nil && node.Right == nil {
            count++
        }
        dfs(node.Left, node)
        dfs(node.Right, node)
    }

    dfs(root, nil)
    return count
}