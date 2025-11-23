func evaluateTree(root *TreeNode) bool {
    if root.Val == 0 {
        return false
    }
    if root.Val == 1 {
        return true
    }

    leftVal := evaluateTree(root.Left)
    rightVal := evaluateTree(root.Right)

    if root.Val == 2 { // OR
        return leftVal || rightVal
    } else { // root.Val == 3, AND
        return leftVal && rightVal
    }
}