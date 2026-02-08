type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maximizeTheTargetNodes(root1 *TreeNode, root2 *TreeNode) int {
    return dfs(root1) + dfs(root2)
}

func dfs(node *TreeNode) int {
    if node == nil {
        return 0
    }
    return 1 + dfs(node.Left) + dfs(node.Right)
}