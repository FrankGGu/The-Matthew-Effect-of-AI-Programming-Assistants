func reverseOddLevels(root *TreeNode) *TreeNode {
    var dfs func(*TreeNode, *TreeNode, int)
    dfs = func(node1 *TreeNode, node2 *TreeNode, level int) {
        if node1 == nil || node2 == nil {
            return
        }
        if level%2 != 0 {
            node1.Val, node2.Val = node2.Val, node1.Val
        }
        dfs(node1.Left, node2.Right, level+1)
        dfs(node1.Right, node2.Left, level+1)
    }
    dfs(root.Left, root.Right, 1)
    return root
}