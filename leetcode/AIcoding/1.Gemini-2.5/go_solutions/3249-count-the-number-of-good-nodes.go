func goodNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }

    count := 0

    var dfs func(node *TreeNode, maxVal int)
    dfs = func(node *TreeNode, maxVal int) {
        if node == nil {
            return
        }

        if node.Val >= maxVal {
            count++
        }

        newMaxVal := maxVal
        if node.Val > newMaxVal {
            newMaxVal = node.Val
        }

        dfs(node.Left, newMaxVal)
        dfs(node.Right, newMaxVal)
    }

    dfs(root, root.Val)

    return count
}