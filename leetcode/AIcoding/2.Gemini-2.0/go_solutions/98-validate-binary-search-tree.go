func isValidBST(root *TreeNode) bool {
    return isValidBSTHelper(root, nil, nil)
}

func isValidBSTHelper(root *TreeNode, min *TreeNode, max *TreeNode) bool {
    if root == nil {
        return true
    }

    if min != nil && root.Val <= min.Val {
        return false
    }

    if max != nil && root.Val >= max.Val {
        return false
    }

    return isValidBSTHelper(root.Left, min, root) && isValidBSTHelper(root.Right, root, max)
}