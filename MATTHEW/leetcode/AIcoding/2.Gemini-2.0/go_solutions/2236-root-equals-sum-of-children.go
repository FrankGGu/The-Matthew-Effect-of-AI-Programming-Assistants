func checkTree(root *TreeNode) bool {
    if root == nil {
        return true
    }
    if root.Left == nil && root.Right == nil {
        return true
    }

    sum := 0
    if root.Left != nil {
        sum += root.Left.Val
    }
    if root.Right != nil {
        sum += root.Right.Val
    }

    return root.Val == sum
}