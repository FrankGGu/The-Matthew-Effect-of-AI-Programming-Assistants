func isSumEqual(root *TreeNode) bool {
    leftVal := 0
    if root.Left != nil {
        leftVal = root.Left.Val
    }

    rightVal := 0
    if root.Right != nil {
        rightVal = root.Right.Val
    }

    return root.Val == (leftVal + rightVal)
}