package main


func sumEvenGrandparent(root *TreeNode) int {
    var result int
    var dfs func(*TreeNode, *TreeNode, *TreeNode)
    dfs = func(grandParent *TreeNode, parent *TreeNode, node *TreeNode) {
        if grandParent != nil && grandParent.Val%2 == 0 {
            result += node.Val
        }
        if node == nil {
            return
        }
        dfs(parent, node, node.Left)
        dfs(parent, node, node.Right)
    }
    dfs(nil, nil, root)
    return result
}