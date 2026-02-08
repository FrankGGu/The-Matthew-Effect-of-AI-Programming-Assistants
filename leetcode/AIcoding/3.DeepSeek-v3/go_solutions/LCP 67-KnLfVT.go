/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func expandBinaryTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }
    if root.Left != nil {
        left := &TreeNode{Val: -1, Left: expandBinaryTree(root.Left)}
        root.Left = left
    }
    if root.Right != nil {
        right := &TreeNode{Val: -1, Right: expandBinaryTree(root.Right)}
        root.Right = right
    }
    return root
}