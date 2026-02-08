func sumEvenGrandparent(root *TreeNode) int {
    sum := 0
    var dfs func(*TreeNode, *TreeNode, *TreeNode)
    dfs = func(node *TreeNode, parent *TreeNode, grandparent *TreeNode) {
        if node == nil {
            return
        }
        if grandparent != nil && grandparent.Val%2 == 0 {
            sum += node.Val
        }
        dfs(node.Left, node, parent)
        dfs(node.Right, node, parent)
    }
    dfs(root, nil, nil)
    return sum
}