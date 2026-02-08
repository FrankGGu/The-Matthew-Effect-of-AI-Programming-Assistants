func inorderSuccessor(root *TreeNode, p *TreeNode) *TreeNode {
    var successor *TreeNode

    for root != nil {
        if p.Val < root.Val {
            successor = root
            root = root.Left
        } else {
            root = root.Right
        }
    }
    return successor
}