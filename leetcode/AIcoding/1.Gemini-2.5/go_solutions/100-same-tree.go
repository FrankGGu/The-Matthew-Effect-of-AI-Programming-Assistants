func isSameTree(p *TreeNode, q *TreeNode) bool {
    // If both nodes are nil, they are identical
    if p == nil && q == nil {
        return true
    }
    // If one node is nil and the other is not, they are not identical
    if p == nil || q == nil {
        return false
    }
    // If values are different, they are not identical
    if p.Val != q.Val {
        return false
    }
    // Recursively check left and right subtrees
    return isSameTree(p.Left, q.Left) && isSameTree(p.Right, q.Right)
}