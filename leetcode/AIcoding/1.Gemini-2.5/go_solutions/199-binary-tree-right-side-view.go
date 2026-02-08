func rightSideView(root *TreeNode) []int {
    result := []int{}

    var dfs func(node *TreeNode, depth int)
    dfs = func(node *TreeNode, depth int) {
        if node == nil {
            return
        }

        if depth == len(result) {
            result = append(result, node.Val)
        }

        dfs(node.Right, depth + 1)
        dfs(node.Left, depth + 1)
    }

    dfs(root, 0)
    return result
}