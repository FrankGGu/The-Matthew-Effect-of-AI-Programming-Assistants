/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func isBalanced(root *TreeNode) bool {
    return height(root) != -1
}

func height(node *TreeNode) int {
    if node == nil {
        return 0
    }
    leftHeight := height(node.Left)
    if leftHeight == -1 {
        return -1
    }
    rightHeight := height(node.Right)
    if rightHeight == -1 {
        return -1
    }
    if abs(leftHeight-rightHeight) > 1 {
        return -1
    }
    return max(leftHeight, rightHeight) + 1
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}