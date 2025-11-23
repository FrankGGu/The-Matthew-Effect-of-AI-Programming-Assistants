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
        left := depth(node.Left)
        right := depth(node.Right)
        maxDiameter = max(maxDiameter, left + right)
        return max(left, right) + 1
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