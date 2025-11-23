package main


func isValidBST(root *TreeNode) bool {
    return helper(root, nil, nil)
}

func helper(node *TreeNode, min *int, max *int) bool {
    if node == nil {
        return true
    }
    if min != nil && node.Val <= *min {
        return false
    }
    if max != nil && node.Val >= *max {
        return false
    }
    return helper(node.Left, min, &node.Val) && helper(node.Right, &node.Val, max)
}