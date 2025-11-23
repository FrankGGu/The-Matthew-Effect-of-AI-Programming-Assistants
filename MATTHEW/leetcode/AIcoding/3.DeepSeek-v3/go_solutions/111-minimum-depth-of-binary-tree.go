/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func minDepth(root *TreeNode) int {
    if root == nil {
        return 0
    }
    if root.Left == nil && root.Right == nil {
        return 1
    }
    leftDepth := minDepth(root.Left)
    rightDepth := minDepth(root.Right)
    if root.Left == nil {
        return rightDepth + 1
    }
    if root.Right == nil {
        return leftDepth + 1
    }
    return min(leftDepth, rightDepth) + 1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}