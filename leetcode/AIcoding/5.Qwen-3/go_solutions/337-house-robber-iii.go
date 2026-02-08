package main


func rob(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return max(rob(root.Left)+rob(root.Right), root.Val+rob(root.Left.left)+rob(root.Left.right)+rob(root.Right.left)+rob(root.Right.right))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}