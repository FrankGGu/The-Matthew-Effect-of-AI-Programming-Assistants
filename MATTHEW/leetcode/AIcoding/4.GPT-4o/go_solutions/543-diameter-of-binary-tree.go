/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func diameterOfBinaryTree(root *TreeNode) int {
    maxDiameter := 0

    var depth func(node *TreeNode) int
    depth = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftDepth := depth(node.Left)
        rightDepth := depth(node.Right)
        maxDiameter = max(maxDiameter, leftDepth + rightDepth)
        return 1 + max(leftDepth, rightDepth)
    }

    depth(root)
    return maxDiameter
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}