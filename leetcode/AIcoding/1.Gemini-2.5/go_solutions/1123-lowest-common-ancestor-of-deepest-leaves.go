func lcaDeepestLeaves(root *TreeNode) *TreeNode {
    var dfs func(node *TreeNode) (int, *TreeNode)
    dfs = func(node *TreeNode) (int, *TreeNode) {
        if node == nil {
            return 0, nil
        }

        leftDepth, leftLCA := dfs(node.Left)
        rightDepth, rightLCA := dfs(node.Right)

        if leftDepth == rightDepth {
            return 1 + leftDepth, node
        } else if leftDepth > rightDepth {
            return 1 + leftDepth, leftLCA
        } else {
            return 1 + rightDepth, rightLCA
        }
    }

    _, lca := dfs(root)
    return lca
}