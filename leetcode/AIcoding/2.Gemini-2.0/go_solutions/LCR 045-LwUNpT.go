func findBottomLeftValue(root *TreeNode) int {
    var result int
    var maxDepth int

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, depth int) {
        if node == nil {
            return
        }

        if node.Left == nil && node.Right == nil {
            if depth > maxDepth {
                maxDepth = depth
                result = node.Val
            }
            return
        }

        dfs(node.Left, depth+1)
        dfs(node.Right, depth+1)
    }

    dfs(root, 1)
    return result
}