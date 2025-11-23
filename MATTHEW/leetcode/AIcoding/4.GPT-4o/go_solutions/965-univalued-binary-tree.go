/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func isUnivalTree(root *TreeNode) bool {
    if root == nil {
        return true
    }
    return isUnival(root, root.Val)
}

func isUnival(node *TreeNode, val int) bool {
    if node == nil {
        return true
    }
    if node.Val != val {
        return false
    }
    return isUnival(node.Left, val) && isUnival(node.Right, val)
}