package main


func isSymmetric(root *TreeNode) bool {
    if root == nil {
        return true
    }
    return isSame(root.Left, root.Right)
}

func isSame(left *TreeNode, right *TreeNode) bool {
    if left == nil && right == nil {
        return true
    }
    if left == nil || right == nil {
        return false
    }
    return left.Val == right.Val && isSame(left.Left, right.Right) && isSame(left.Right, right.Left)
}